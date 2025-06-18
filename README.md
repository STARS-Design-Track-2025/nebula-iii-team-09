# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Run STARS Submission Checks](https://github.com/STARS-Design-Track-2025/nebula-iii/actions/workflows/stars_submission_checks.yml/badge.svg)](https://github.com/STARS-Design-Track-2025/nebula-iii/actions/workflows/stars_submission_checks.yml) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

| :exclamation: Important Note            |
|-----------------------------------------|

## Please fill in your project documentation in this README.md file 

Refer to [README](docs/source/index.rst#section-quickstart) for a quickstart of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 

Refer to the following [readthedocs](https://caravel-sim-infrastructure.readthedocs.io/en/latest/index.html) for how to add cocotb tests to your project. 

## Getting Started (For Mentors)

This repository should contain all of the instructions, base files, and scripts for an `openlane2` Caravel project.  
Have the students follow the [Getting Started (For Students)](https://github.com/STARS-Design-Track-2025/nebula-iii?tab=readme-ov-file#getting-started-for-students) section below and approve pull requests ONLY when the 
team is completely done and has passed all of the GitHub actions checks. The major requirements are that teams have a successful 
testbench that PROGRAMMATICALLY tests their designs and that they pass some of the formatting checks. If you (TAs) 
discover issues during integration, please feel free to update / add to these formatting checks. At a bare minimum, 
their test bench must fail if their design is not present in the design (this is a funny requirement, but we 
have had multiple teams' test benches pass before with their entire design commented out ☺ ).

## Getting Started (For Students)

1. Create a fork of this repository. Please fork it to our **STARS-Design-Track-2025** organization (ask peer mentor if you're unsure how to do this).

2. To create the initial files for your team, run `make init_team_##` where ## is your 2-digit team number in decimal (if you don't know what your team number is, ask your peer mentor).

3. Navigate to `verilog/rtl/team_projects/team_##/team_##.yml`
This file contains configuration information that our targets will use to generate top level and wrapper files
You are allowed to use both the Logic Analyzer (LA) and Wishbone Master interface (WB_master). Each of these
will increase the perimeter of your design, but can add important and interesting functionality. Choose if you'll use these now. You can always change them later, but you will need to rerun `make nebula` (step #5 explains what this does).

```yaml
project_info:
  wb_master_enabled: False
  la_enabled: False
```

4. If bus-wrap is not setup yet, run `make bus-wrap-setup`

5. Run `make nebula` to generate the top level files. This calls a few Python scripts to combine all of the
teams' designs together and write a few files. These scripts should NOT be changed, but if you're interested,
you can see them in the `scripts` folder.

6. The template project provided by ChipFoundry is relatively uninteresting, but should be able to be run through all of these steps.
To see a more interesting example, see `team_00`, the sample project.

7. To verify your design, you will first need to setup the testing environment. To do this, run `make purdue-setup`. Then, to verify the RTL code for your design, run make `purdue-verify-team_##-rtl`.  This will run the testbench located in `verilog/dv/team_##/team_##_tb.v`

8. Once your design is passing your source-level (RTL) simulation, you will need to harden your team's macro (using OpenLane), place the macro within the top level User Project Wrapper, and harden the top level. This generates a gate-level netlist that will then be used for simulations. Switch to the nanoHUB environment and run `make team_##` to harden your design. Manually place your design within `openlane/user_project_wrapper/macro.cfg` (follow the example of Team 00). Run `make user_project_wrapper` to harden the top level. This will take a while (at least an hour).

9. Run `make purdue-verify-team_##-gl`. This will take a while, but should produce the same results as your source simulation. If the results match, you are good to begin submitting your design.

10. There is a GitHub action that will identify some conflicts that we have had in the past. These are primarily naming conventions and you can see the results if you click on the actions tab on the web version of GitHub. To be approved for the final chip, you must pass each of these checks. If you find a bug, please feel free to report it.

11. Once your simulations are good and you are passing the GitHub action, you can create a **Pull Request** with your changes. Please do this to a branch on your repository other than main. If not, you will be asked to resubmit. If you need help with this, feel free to ask your peer mentor.
