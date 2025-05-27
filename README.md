# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

| :exclamation: Important Note            |
|-----------------------------------------|

## Please fill in your project documentation in this README.md file 

Refer to [README](docs/source/index.rst#section-quickstart) for a quickstart of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 

Refer to the following [readthedocs](https://caravel-sim-infrastructure.readthedocs.io/en/latest/index.html) for how to add cocotb tests to your project. 

## Getting Started (For Mentors)

This repository should contain all of the instructions, base files, and scripts for an openlane2 caravel project.  
Have the students follow the getting started (for students) section below and approve pull requests ONLY when the 
team is completely done and has passed all of the checks.  The major requirements are that teams have a successful 
testbench that PROGRAMMATICALLY tests their designs and that they pass some of the formatting checks.  If you (TAs) 
discover issues during integration, please feel free to update / add to these formatting checks. At a bare minimum, 
their test bench must fail if their design is not present in the design (this is a funny requirement, but we 
have had multiple teams' test benches pass before with their entire design commented out ☺ ).

## Getting Started (For Students)

You will first need to create a fork of this repository.  You can fork it to our design-track organization or one of your personal accounts.

To create the files for your team, run "make init_team_##" where ## is your 2 digit team number in decimal

Then, you should navigate to /verilog/rtl/team_projects/team_##/team_##.yml
This file contains configuration information that our targets will use to generate top level and wrapper files
You are allowed to use both the Logic Analyzer (LA) and Wishbone Master interface (WB_master).  Each of these
will increse the perimeter of your design, but can add important and interesting functionality.  Choose these
now.  You can always change them later, but you will need to rerun "make nebula".

project_info:
  wb_master_enabled: False
  la_enabled: False

If bus-wrap is not setup yet, run "make bus-wrap-setup"

Run "make nebula" to generate the top level files.  This calls a few python scripts to combine all of the
teams' designs together and write a few files.  These scripts should NOT be changed, but if you're interested,
you can see them in the /scripts folder.

The template project is relatively uninteresting, but should be able to be run through all of these steps.
To see a more interesting example, see team_00, the sample project.

To verify your design, you will first need to setup the testing environment.  To do this, run "make purdue-setup"

Then, to verify the rtl for your design, run "make purdue-verify-team_##-rtl".  This will run /verilog/dv/team_##/team_##_tb.v

Once your design is passing your source-level (rtl) simulation, you will need to harden your team's macro, place the macro within the top level, and harden the top level.  This generates a gate list that will then be used for simulations.

Run "make team_##" to harden your design.
Manually place your design within openlane/user_project_wrapper/macro.cfg
Run "make user_project_wrapper" to harden the top level.  This will take a while.

Run "make purdue-verify-team_##-gl".  This will take a while, but should produce the same results as your source simulation.  If the results match, you are good to begin submitting your design.

There is a GitHub action that will identify some conflicts that we have had in the past.  These are primarily naming conventions and you can see the results if you click on the actions tab on the web version of GitHub.  To be approved for the final chip, you must pass each of these checks.  If you find a bug, please feel free to report it.

Once your simulations are good and you are passing the GitHub action, you can create a Pull Request with your changes.  Please do this to a branch on the main repository other than main.  If not, you will be asked to resubmit.  If you need help with this, feel free to ask a TA.
