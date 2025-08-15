# Project Report

**Contributor**: Harsh Mishra

**Mentors**: Dr. Nijso Beishuizen, Dr. Edwin van der Weide

**Project**: Automating SU2 Validation Cases with GitHub Actions — A Scalable CI/CD Pipeline for V&V

**Organization**: [SU2 Foundation](https://su2code.github.io)

**Description**:  
This project delivers an automation framework for running, verifying, and publishing **SU2** validation cases using **GitHub Actions**. It enables fully reproducible and scalable verification & validation (V&V) of CFD solvers without manual intervention.

The system comprises **two coordinated workflows**:

1. **Main Workflow** – Builds SU2, runs the selected validation cases, and generates results.
2. **Results Publishing Workflow** – Processes outputs, generates Markdown case pages, updates the V&V site data, and commits changes to the results repository.

The workflow handles everything from **fetching meshes/restart data**, **building SU2 from source**, **executing cases**, **generating plots**, to **publishing web-ready reports** — all through a single parameterized workflow dispatch.

---

## What Work Was Done

### 1. **Main Workflow**

The core workflow focuses on robust, end-to-end automation:

- **Input Validation & Sanitization**
  - Ensures logical combinations of category, case code, turbulence model, and configuration.
- **Dynamic Asset Acquisition**
  - Downloads only required meshes and restart files from Google Drive based on user inputs.
  - Uses a JSON-based file mapping to identify necessary assets.
- **Environment Setup**
  - Installs system dependencies (Boost, METIS, HDF5, etc.).
  - Installs Python dependencies (NumPy, Matplotlib, PyVista, Pandas).
  - Builds SU2 from the specified branch using `meson` and `ninja` with PyWrapper enabled and MPI disabled.
- **Automated Execution**
  - Invokes `Automation.py` per case/configuration to generate consistent result folders and plots.
  - Handles all combinations: single case, category, or complete suite.
- **Artifact Management & Deployment**
  - Uploads results as GitHub Actions artifacts.
  - Pushes plots and results to a dedicated branch of the results repository.
- **Cleanup**
  - Removes generated mesh/output files to restore repository state.

---

### 2. **Results Publishing Workflow**

This companion workflow processes and integrates results into the public-facing V&V site:

- **Validation of Inputs**
  - Enforces consistency between case code, case name, and flow condition.
- **Branch Handling**
  - Checks for the existence of the target results branch and checks it out.
- **Markdown Generation**
  - For all-cases runs: creates an aggregated `All_Validation_Cases.md`.
  - For single-case runs: generates dedicated case Markdown pages from a template.
  - Embeds plots with appropriate sizing and formatting.
- **V&V Listing Update**
  - Updates `_data/vandv.yml` to include new validation cases or all-cases sections.
  - Ensures updates preserve existing content.
- **Commit & Push**
  - Commits changes to the results branch for immediate availability on the site.

---

## Benefits of the Workflow

1. **Reproducibility** – Any case can be re-run with identical configurations.
2. **Scalability** – Handles single cases or entire validation suites.
3. **Traceability** – Results are archived as artifacts and committed to version control.
4. **Low-friction Sharing** – Automatically generates web-ready outputs for collaborators and reviewers.

---

## What’s Left to Do

- **Parallel Execution** – To reduce turnaround time for large validation suites.
- **Automated Regression Checks** – Integrate benchmark comparison to detect deviations early.
- **Extended Coverage** – Expand automation to all NASA Turbulence Modelling Resource benchmark cases.

---

## Important Links

- **Main Workflow** - <a href="https://github.com/su2code/VandV_actions">Vandv_actions</a>
- **Results Publishing Workflow** - <a href="https://github.com/su2code/su2code.github.io">SU2 Project Website</a>

---

## Acknowledgement

I sincerely thank my mentors, **Dr. Nijso Beishuizen** and **Dr. Edwin van der Weide**, for their guidance, technical advice, and encouragement throughout the project. This experience deepened my expertise in **CI/CD for scientific software**, **workflow automation**, and **open-source CFD development**.

It has been a rewarding journey contributing to the **SU2 Foundation**, and I look forward to extending this work further.
