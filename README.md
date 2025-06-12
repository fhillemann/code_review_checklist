[![CC BY-NC 4.0][cc-by-nc-shield]][cc-by-nc]

[cc-by-nc]: https://creativecommons.org/licenses/by-nc/4.0/
[cc-by-nc-shield]: https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15649079.svg)](https://doi.org/10.5281/zenodo.15649079)

# Code Review Checklist – Shiny App

---

### About

This Shiny app supports code review for scientists —whether through self-assessment or peer review— by offering specific prompts for evaluating and improving the code's technical functionality and documentation across seven key dimensions of reusability:  
Reporting, Running, Reproducibility, Reliability, Robustness, Readability, and Release.  

**How to use this app locally:**
1. Download the file (`app.R`) and open it in R or RStudio.
2. To start the app, either:
   a) run the script in its entirety, or
   b) in the Console, run the following:
     ```r
     setwd("path/to/your/appfolder")  # Provide path to directory where app.R is saved!
     shiny::runApp()
     ```
3. Once the app opens in your browser:
   - fill in the metadata section at the top
   - work through the checklist and add comments if needed
   - click “save report as .md” to download your review as a Markdown file
4. You can then edit, save, convert, and share the report as you like

---

### Requirements

This app was developed and tested on the following versions; other versions may work, but these were used during development:

- macOS 15.4.1  
- R version 4.4.3  

Required R packages, tested versions:

- `shiny`: `1.10.0`  
- `shinyjs`: `2.1.0`  
- `shinythemes`: `1.2.0`

The script checks for these packages and installs them if missing.

---

### Preview

Here's a screenshot of the app's user interface:

![Code Review App Preview](checklist_app_ui_screenshot.png)

---

### License and Attribution

This checklist and the app are shared under a [CC BY-NC 4.0 License](https://creativecommons.org/licenses/by-nc/4.0/), allowing reuse and adaptation for non-commercial purposes, provided attribution is given. If you use, build on, or adapt this app, please attribute as follows:

> Adapted from the Code Review Checklist available at https://github.com/fhillemann/code_review_checklist and archived at https://doi.org/10.5281/zenodo.15649079, licensed under CC BY-NC 4.0.

---

### Associated Paper

This app accompanies a paper that outlines the need for code review to strengthen reproducibility and collaboration in computational biology, and in scientific research more broadly. The abstract is included below. The manuscript is freely available as an open access preprint:

> Hillemann F, Burant JB, Culina A, Vriend SJG. (2025). Code Review in Practice: A Checklist for Computational Reproducibility and Collaborative Research in Ecology and Evolution. *EcoEvoRxiv* Preprint Server. [https://doi.org/10.32942/X26S6P](https://doi.org/10.32942/X26S6P) 

**Abstract**  
Ensuring that research, along with its data and code, is credible and accessible is crucial for progress especially in ecology and evolutionary biology, especially given that the climate crisis and biodiversity loss demand urgent, transparent science. Yet, code is rarely shared alongside scientific publications, and when it is, poor documentation and unclear implementation often hinder reuse. Targeted code review can improve key aspects of code quality: reusability (technical functionality and documentation) and validity (ensuring the code implements the intended analyses faithfully). While assessing validity requires domain expertise, reviewing the reusability of code can be done by anyone with basic programming knowledge. To make code review accessible for researchers with diverse coding experience, we introduce a list of guiding questions organised around seven key attributes of reusable scientific code: Reporting, Running, Reliability, Reproducibility, Robustness, Readability, and Release. We built an open-source companion app with an intuitive, interactive checklist interface that lets users export an editable Markdown report with comments for archiving or sharing. By defining and operationalising these principles of code review, our tool supports an approachable and systematic yet flexible review process, whether for self-assessment or peer review. Informed by best practices in software development and community recommendations, the 7Rs-checklist clarifies standards for research code quality and promotes reproducible coding, thereby strengthening research credibility. It also provides a valuable resource for teaching and training by helping to structure conversations around code quality and collaboration in research.

---
