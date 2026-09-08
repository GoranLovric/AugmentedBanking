library(shiny)
library(httr)
library(jsonlite)
library(htmltools)
library(DBI)
library(RSQLite)
library(shinycssloaders)

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
if (length(file_arg) > 0) {
  script_path <- sub("^--file=", "", file_arg[1])
  script_dir <- dirname(normalizePath(script_path))
  setwd(script_dir)
}

api_key <- "your_key_here"

skill_files <- c("email.md")

read_skill_file <- function(path) {
  paste(readLines(path, warn = FALSE), collapse = "\n")
}

system_prompt <- paste(vapply(skill_files, read_skill_file, character(1)), collapse = "\n\n")

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .main-container {max-width: 800px; margin: auto;}
      .shiny-output-error {color: red;}
      textarea.form-control {font-family: 'Fira Mono', 'Consolas', 'Monaco', monospace;}
      .response-box {background: #f8f9fa; border-radius: 6px; padding: 16px; margin-top: 20px;}
      .btn-primary {background-color: #007bff; color: white;}
    "))
  ),
  div(class = "main-container",
      h2("AI Agent"),
      p("Assign a task to the AI Agent"),
      textAreaInput("user_prompt", "User Prompt", 
                    value = "Attach file xy and send to John Johnson",
                    rows = 4, width = "100%"),
      actionButton("send", "send", class = "btn-primary"),
      withSpinner(uiOutput("response"), type = 6)
  )
)

server <- function(input, output, session) {
  response <- eventReactive(input$send, {
    req(input$user_prompt)
    # API Call
    res <- POST(
      url = "your_endpoint_here",
      add_headers(
        Authorization = paste("Bearer", api_key),
        "Content-Type" = "application/json"
      ),
      body = toJSON(list(
        model = "your_model", #e.g. gpt-5.4-mini
        messages = list(
          list(role = "system", content = system_prompt),
          list(role = "user", content = input$user_prompt)
        ),
        max_completion_tokens = 32000
      ), auto_unbox = TRUE)
    )
    res_content <- content(res, as = "parsed", encoding = "UTF-8")
    ai_reply <- res_content$choices[[1]]$message$content
    ai_reply <- gsub("```r|```", "", ai_reply)
    ai_reply <- trimws(ai_reply)
    
    result <- tryCatch({
      eval_result <- capture.output(eval(parse(text = ai_reply)))
      paste(eval_result, collapse = "\n")
    }, error = function(e) {
      paste("Error executing code: ", e$message)
    })
    list(ai_reply = ai_reply, result = result)
  })
  
  output$response <- renderUI({
    req(response())
    div(class = "response-box",
        h4("Agent reponse: "),
        pre(response()$ai_reply),
        h4("Result of the code execution: "),
        pre(response()$result)
    )
  })
}

shiny::runApp(shinyApp(ui, server), launch.browser = TRUE)



