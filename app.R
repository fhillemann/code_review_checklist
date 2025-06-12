# _________________________________________________________________________________________________________________________________
# _________________________________________________________________________________________________________________________________
#
# Code Review Checklist - Shiny App
#
# ABOUT:
# This app supports code review for scientists across seven key dimensions of reusability:
# Reporting, Running, Reproducibility, Reliability, Robustness, Readability, and Release.
# Whether used as a tool for self-assessment or peer review, users rate each subcriterion and add comments.
#
# How to use this app locally:
# 1. Download this file (app.R) and open it in R or RStudio
# 2. To start the app, either:
#    a) Run the whole script in its entirety, or
#    b) In the Console, run these two lines:
#       setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # only works in RStudio, alternatively use the following:
#       # setwd("path/to/your/appfolder")  # Provide path to directory where app.R is saved!
#       shiny::runApp()
# 3. Once the app opens in your browser:
#    - fill in the metadata section at the top
#    - work through the checklist and add comments if needed
#    - click 'save report as .md' to download your review as a Markdown file
# 4. You can then edit, save, and share the report as you like
#
#
# REQUIREMENTS:
# This app was developed and tested on the following versions; other versions may work, but these were used during development:
#   - MacOS 15.4.1
#   - R version 4.4.3
# Required R packages, tested versions:
#   - shiny: 1.10.0
#   - shinyjs: 2.1.0
#   - shinythemes: 1.2.0
# The script checks for these packages and installs them if missing.
#
#
# LICENSE:
# This checklist and the app are shared under a CC BY-NC 4.0 License, allowing reuse and adaptation for non-commercial purposes,
# provided attribution is given. Full license details: https://creativecommons.org/licenses/by-nc/4.0/.
#
#
# ATTRIBUTION:
# If you use, build on, or adapt this app, please attribute as follows:
# Adapted from: Code review checklist archived at https://doi.org/10.12345/zenodo.12345, licensed under CC BY-NC 4.0.
#
# 
# ASSOCIATED PAPER:
# This app accompanies a paper that outlines the need for code review to strengthen reproducibility and collaboration in 
# computational biology, and in scientific research more broadly. The manuscript is freely available as an open access preprint:
#
# Hillemann F, Burant JB, Čulina A, Vriend SJG. (2025).
# Code Review in Practice: A Checklist for Computational Reproducibility and Collaborative Research in Ecology and Evolution.
# EcoEvoRxiv Preprint Server. DOI: https://doi.org/10.32942/X26S6P
#
# _________________________________________________________________________________________________________________________________
# _________________________________________________________________________________________________________________________________


# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                              xxxx
# install/load dependencies                    ####
#                                              xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# install (if needed), and load required packages
required_packages <- c("shiny", "shinyjs", "shinythemes")

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}



# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                               xxxx
# seven R principles and subquestions           ####
#                                               xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

r_principles <- list(
  # Reporting -------------------------------------#
  list(
    title = "Reporting — Check that it does what it claims.",
    description = "Code should match the reported methods. Data transformations and analyses should align with the description—missing or altered steps mean the code is not as reported.",
    subquestions = list(
      "Methods Alignment",
      "Documentation"
    ),
    subq_descriptions = list(
      "Does the code implement the methods as described in the associated documentation or research outputs?",
      "Is there sufficient metadata (e.g., in a README file or code header) to understand and use the code independently of external documentation?	"
    )
  ),

  # Running ---------------------------------------#
  list(
    title = "Running — Check that it works.",
    description = "Code should execute on a local machine and run its entirety, even for users with limited coding expertise.",
    subquestions = list(
      "Functioning",
      "Dependencies",
      "Cross-Platform Compatibility",
      "Run Time",
      "Complete Check"
    ),
    subq_descriptions = list(
      "Does the code run without errors from start to finish?",
      "Does the code specify all required libraries/packages or install them automatically (e.g., via groundhog::groundhog.library() or renv::restore() in R)?",
      "Does the code run on a different operating system than the one it was developed on?",
      "Does the code provide information on run time to manage user expectations?",
      "Did you run the entire code?"
    )
  ),
    
  # Reproducibility -------------------------------#
  list(
    title = "Reproducibility — Check that it gives consistent results.",
    description = "Code should produce the same output when run with the same input data and computational conditions (including a random seed for stochastic processes like simulations or MCMC).",
    subquestions = list(
      "Numerical Reproducibility",
      "Visual Reproducibility",
      "Requirements",
      "Compartmentalisation"
    ),
    subq_descriptions = list(
      "Does the code generate the same functional outputs (e.g., descriptive statistics, model estimates, or predictions) with identical input?",
      "Does the code generate consistent visual outputs (e.g., figures, maps) across repeated executions with the same input?",
      "Does the code include or clearly specify all necessary data, or provide mock data where applicable, to enable independent reproduction?",
      "Does the code ensure the workflow is self-contained, with all external software dependencies documented and accessible for execution in other environments?"
    )
  ),

  # Reliability -----------------------------------#
  list(
    title = "Reliability — Check that it behaves as expected under known conditions.",
    description = "Code should perform as intended under typical use cases, producing expected results and including internal checks for common issues to catch errors early.",
    subquestions = list(
      "Input Validation",
      "Stepwise Output Checks"
    ),
    subq_descriptions = list(
      "Does the code check data formats or value ranges of external inputs or other internal assumptions, e.g., confirming no negative values where only positives are expected?",
      "Does the code verify that key transformations or computations perform as intended, e.g., checking factor levels are preserved after merging?"
    )
  ),

  # Robustness ------------------------------------#
  list(
    title = "Robustness — Check that it remains functional under change and handles unexpected inputs gracefully.",
    description = "Code should handle invalid inputs gracefully and fail safely, providing meaningful feedback. It should avoid brittle design and support flexible workflows.",
    subquestions = list(
      "Parameterisation & Portability",
      "Streamlined Design",
      "Functional Programming Principles",
      "Warnings & Error Handling"
    ),
    subq_descriptions = list(
      "Does the code avoid hard-coding and instead use flexible and  generalisable solutions, e.g., relative file paths or transferable parameters?",
      "Does the code include only relevant parts, reducing clutter and minimising the risk of confusion or errors?",
      "Does the code use modular components to support structural resilience and debugging, e.g., using tidyverse functions and pipelines to process data in R?",
      "Does the code provide clear comments, warnings, or error messages to flag potential issues, e.g. related to data quality or input constraints?"
    )
  ),
    
  
  # Readability -----------------------------------#
  list(
    title = "Readability — Check that it is clear and clean.",
    description = "Code should be easy to follow, well-structured and logically organised like a manual, and naming of variables and functions should be easy to understand.",
    subquestions = list(
      "Organisation",
      "Modularity",
      "Naming Conventions",
      "Style Conventions"
    ),
    subq_descriptions = list(
      "Does the code follow a logical order that clearly conveys its purpose and guides users through the workflow?",
      "Does the code consist of manageable sections for different tasks (e.g., functions, sections, modular scripts) that together form a coherent workflow?",
      "Does the code use informative names for variables, functions, and objects?",
      "Does the code consistently follow a style guide, such as tidyverse style for R?"
    )
  ),

  # Release ---------------------------------------#
  list(
    title = "Release — Check that it is ready for sharing and reuse.",
    description = "Code should be prepared for sharing, include licensing, citation information, and relevant metadata to support reuse and attribution.",
    subquestions = list(
      "Contact",
      "Legal Permissions",
      "Attribution"
    ),
    subq_descriptions = list(
      "Do the authors or maintainers provide guidance on how to report feedback or seek support?",
      "Does the code include a licence specifying how it can be used, modified, and shared?",
      "Does the code have a Persistent Identifier (e.g., Digital Object Identifier DOI), making it easy to cite and give proper credit in academic and research contexts?"
    )
  )
)


# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                               xxxx
# user interface (UI)                           ####
#                                               xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

ui <- fluidPage(
  
  # enable use of JavaScript functions, e.g. toggling UI elements such as hide/show README
  useShinyjs(),
  
  # custom style and CSS rules --------------------#
  theme = shinytheme("lumen"),
  
  tags$style(HTML("
  h2, h3 {
    color: #158cba;
    font-weight: bold;
  }

  .citation-box {
    background-color: #f8f9fa;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-family: 'Courier New', Courier, monospace;
    font-size: 0.9em;
    line-height: 1.5;
    padding: 20px;
    margin: 5px;
    white-space: normal;
    overflow-wrap: anywhere;
  }
    
  .comment-field textarea {
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 0.9em;
    padding: 10px;
    width: 100%;
    box-sizing: border-box;
    resize: vertical;
  }
  
  .comment-field textarea:focus {
    border-color: #158cba;
    box-shadow: 0 0 5px rgba(21, 140, 186, 0.5);
  }

  .comment-field textarea::placeholder {
    font-size: 1.1em;
  }
  
  .thick-hr {
    border-top: 3px solid #000;
    margin-bottom: 30px;
    margin-top: 30px;
  }
  
  ")),
  
  # title and intro -------------------------------#
  titlePanel("Code Review Checklist"),
  tags$p(HTML("<strong>This checklist supports code review in scientific contexts, whether through self-assessment or peer review, across seven key dimensions of reusability:<br>
                       Reporting, Running, Reproducibility, Reliability, Robustness, Readability, and Release.</strong>")),
  
  # README toggle ---------------------------------#
  div(
    style = "text-align: left; margin-bottom: 20px;",
    actionLink("toggle_readme", label = span(icon("info-circle"), "Click for more information, license, and how to cite"))
  ),
  
  hidden(
    div(
      id = "readme",
      style = "margin: 5px;",
      tags$p(HTML(
      "<strong>Purpose:</strong><br>
      Code is a core part of scientific methods and outputs. To ensure research is credible and cumulative, code should be transparently shared in a way
      that allows others to run it smoothly, reproduce outputs, and understand, verify, and build on it. This checklist supports code review — whether 
      through self-assessment or peer review — by offering specific prompts for evaluating and improving the technical functionality and documentation.
      Review priorities will vary depending on the context, the phase of development, the reviewer’s expertise, and the code’s intended use. The checklist
      is meant to be used flexibly — users are encouraged to adapt, omit, or expand the prompts as needed. Criteria may be marked as <em>yes</em> (met),
      <em>no</em> (not met), <em>unsure</em> (unclear or not evaluated), or <em>n/a</em> (not applicable). Once complete, the review report can be saved
      as a Markdown file for further editing, archiving, or sharing.<br><br>


      <strong>Access:</strong><br>
      This app accompanies a paper that outlines the need for code review to strengthen reproducibility and collaboration in computational biology,
      and in scientific research more broadly. The abstract is included below. View the full manuscript, freely available as an open access 
      <a href='https://doi.org/10.32942/X26S6P' target='_blank'>preprint via EcoEvoRxiv</a>.
      An editable Markdown version of the checklist and the source code for this Shiny app are available in the paper’s supplementary materials, via 
      <a href='https://github.com/fhillemann/code_review_checklist' target='_blank'>GitHub</a>, and archived at 
      <a href='https://doi.org/10.12345/zenodo.12345' target='_blank'>Zenodo</a>. 
      A PDF version of the checklist is available in the paper’s supplementary materials.<br><br>
    
    
      <strong>License:</strong><br>
      This checklist is shared under a <a href='https://creativecommons.org/licenses/by-nc/4.0/' target='_blank'>Creative Commons BY-NC 4.0 License</a>, 
      allowing reuse and adaptation for non-commercial purposes with attribution. If you use, build on, or adapt this app, please attribute as follows:<br><br>
      
      Attribution of the app example (for use or adaptation):<br>
      <div class='citation-box'>
      Adapted from the Code Review Checklist available at https://github.com/fhillemann/code_review_checklist, and
      archived at https://doi.org/10.12345/zenodo.12345, licensed under CC BY-NC 4.0.
      </div><br>
        
      Citation of the paper example (for academic referencing):<br>
      <div class='citation-box'>
      Hillemann F, Burant JB, Čulina A, Vriend SJG. (2025).  
      Code Review in Practice: A Checklist for Computational Reproducibility and Collaborative Research in Ecology and Evolution.  
      <i>EcoEvoRxiv</i> Preprint Server. DOI: https://doi.org/10.32942/X26S6P
      </div><br>
      
      <strong>Abstract for 'Code Review in Practice' paper </strong><br>
      Ensuring that research, along with its data and code, is credible and remains accessible is crucial for advancing scientific knowledge — 
      especially in ecology and evolutionary biology, where the climate crisis and biodiversity loss demand urgent, transparent science. 
      Yet, code is rarely shared alongside scientific publications, and when it is, unclear implementation and poor documentation often make 
      it difficult to use. Code review — whether as self-assessment or peer review — can improve key aspects of code quality: reusability, i.e.,
      ensuring technical functionality and documentation, and validity, i.e., ensuring the code implements the intended analyses faithfully.
      While assessing validity requires domain expertise, reviewing for reusability can be done by anyone with basic programming knowledge. 
      We introduce a checklist-based, customisable approach to code review focused on reusability. Informed by best practices in software 
      development and community recommendations, the checklist organises prompts around seven key attributes of reusable scientific code: 
      Reporting, Running, Reliability, Reproducibility, Robustness, Readability, and Release. By defining and structuring these principles 
      and turning them into a practical tool, our template supports a systematic yet flexible review process. It also offers researchers 
      a clear path to improve their own code. Ultimately, this approach reinforces reproducible coding practices and strengthens both 
      the credibility and collaborative potential of research.<br><br>
      "))
    )
  ),
  
  # horizontal line -------------------------------#
  hr(class = "thick-hr"),
  
  # review metadata -------------------------------#    
  fluidRow(
    column(6, # left column
           h4("Review Metadata"),
           textInput("code_id", "Review of", placeholder = "e.g. Unicorn population dynamics v1 05/2025"),
           textInput("review_env", "Operating system and software version used", placeholder = "e.g. macOS 13.2, R 4.3.0")
    ),
    
    column(6, # right column
           h4("Reviewer Acknowledgement"),
           textInput("reviewer_name", "Review by", placeholder = "Your name"),
           checkboxInput("ack_named", "I agree to be acknowledged as a code reviewer by name.", value = FALSE),
           checkboxInput("ack_anonym", "I prefer to stay anonymous in the acknowledgements.", value = FALSE)
    )
  ),
  
  # general comments ------------------------------#
  h4("General Comments"),
  tags$div(
    class = "comment-field", 
    textAreaInput(
      inputId = "comment_general",
      label = NULL,
      placeholder = "Use this space for any general remarks that do not fit into specific checklist items.",
      rows = 4,
      width = "100%"
    )
  ),
  
  # horizontal line -------------------------------#
  hr(class = "thick-hr"),
  
  # checklist -------------------------------------#
  tagList(
    do.call(tagList, lapply(seq_along(r_principles), function(i) {
      principle <- r_principles[[i]]
      
      tagList(
        h3(principle$title),
        div(principle$description),
        br(),
        
        do.call(tagList, lapply(seq_along(principle$subquestions), function(j) {
          subq <- principle$subquestions[[j]]
          subq_id <- paste0("r_", i, "_", j)
          comment_id <- paste0("comment_", i, "_", j)
          subq_descripts <- principle$subq_descriptions[[j]]
          
          tagList(
            strong(subq, style = "font-size: 1.2em;"),
            div(subq_descripts, style = "margin-bottom: 10px;"),
            radioButtons(
              inputId = subq_id,
              label = NULL,
              choices = c("yes", "no", "unsure", "n/a"),
              selected = character(0),
              inline = TRUE
            ),
            
            textAreaInput(inputId = comment_id, 
                          label = "Comment:", 
                          placeholder = "Enter any clarifications or recommendations here.",
                          width = "100%"),
            
            hr(style = "border-top: 0.5px solid #000;")
          )
        }))
      )
    }))
  ),
  
  # download button -------------------------------#    
  div(
    style = "
  position: sticky;
  bottom: 0;
  background-color: white;
  padding: 10px;
  border-top: 1px solid #ccc;
  z-index: 1000;
  text-align: center;
  ",
    actionButton("download", label = tagList(icon("download"), "Save report as .md"), class = "btn-primary btn-lg")
  )
)


# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                               xxxx
# generate Markdown report                      ####
#                                               xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

generateReport <- function(input) {
  
  # head of report
  lines <- c(
    "# Code Review Checklist Report", "",
    paste0("**Date:** ", Sys.Date()), "",
    "## Review Metadata", "",
    paste0("- **Review of:** ", input$code_id),
    paste0("- **Environment:** ", input$review_env),
    paste0("- **Reviewer Name:** ", input$reviewer_name),
    paste0("- **Happy to be acknowledged by name:** ", ifelse(input$ack_named, "Yes", "No")),
    paste0("- **Prefer to remain anonymous:** ", ifelse(input$ack_anonym, "Yes", "No")), "",
    "## General Comments", "",
    ifelse(input$comment_general == "", "*No comment provided*", input$comment_general), ""
  )
  
  # loop over seven R principles and subquestions to populate checklist responses
  for (i in seq_along(r_principles)) {
    p <- r_principles[[i]]
    lines <- c(lines, 
               "---", "",
               paste0("## ", p$title), "", 
               p$description, "")
    
    for (j in seq_along(p$subquestions)) {
      subq <- p$subquestions[[j]]
      subq_id <- paste0("r_", i, "_", j)
      comment_id <- paste0("comment_", i, "_", j)
      answer <- input[[subq_id]]
      comment <- input[[comment_id]]
      
      # add subquestion answer, and comment text or "No comment provided"
      lines <- c(lines,
                 paste0("### ", subq),
                 p$subq_descriptions[[j]],
                 paste0("- **Answer:** ", ifelse(length(answer) == 0, "*No answer given*", answer)),
                 paste0("- **Comment:** ", ifelse(comment == "", "*No comment provided*", comment)), ""
      )
    }
  }
  
  # add app attribution
  lines <- c(lines,
             "---", "",
             "> **License and Attribution**", 
             "> Adapted from the Code Review Checklist available at https://github.com/fhillemann/code_review_checklist, and",  
             "> archived at https://doi.org/10.12345/zenodo.12345. Licensed under CC BY-NC 4.0.",
             "> **Associated paper:**",
             "> Hillemann F, Burant JB, Čulina A, Vriend SJG. (2025). *EcoEvoRxiv* Preprint Server. https://doi.org/10.32942/X26S6P",  
             "> *Code Review in Practice: A Checklist for Computational Reproducibility and Collaborative Research in Ecology and Evolution*.", ""
  )
  
  # combine everything into a single Markdown string
  paste(lines, collapse = "\n")
}


# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                               xxxx
# server-side processes                         ####
#                                               xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

server <- function(input, output, session) {
  
  # enable JavaScript, needed to toggle visibility and trigger .md file download
  useShinyjs()
  
  # toggle README display
  observeEvent(input$toggle_readme, {
    toggle("readme")
  })
  
  # handle report download via JS
  observeEvent(input$download, {

    # temporary message to user
    showModal(modalDialog("Preparing your report...", footer = NULL))
    Sys.sleep(1.5) # small delay to keep the messave visible
    removeModal()
    
    # generate Markdown-formatted report
    reportText <- generateReport(input)
    encodedText <- URLencode(reportText, reserved = TRUE)  # Encode Markdown safely
    
    session$sendCustomMessage("download_report", list(content = encodedText))
  })
  
  # send file contents from R to the browser so the user can download via JavaScript
  session$onFlushed(function() {
    insertUI(
      selector = "body",
      where = "beforeEnd",
      ui = tags$script(HTML("
      Shiny.addCustomMessageHandler('download_report', function(message) {
        // JavaScript code here
        const a = document.createElement('a');
        a.href = 'data:text/markdown;charset=utf-8,' + message.content;
        a.download = 'code_review_report.md';
        a.style.display = 'none';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
      });
    "))
    )
  })
}


# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#                                              xxxx
# run app                                      ####
#                                              xxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

shinyApp(ui = ui, server = server)

# end
