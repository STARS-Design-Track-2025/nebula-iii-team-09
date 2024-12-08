import os
import glob

def find_root_directory(start_path, target_root="nebula-iii"):
    current_path = start_path
    
    while current_path != os.path.dirname(current_path):  # Loop until we reach the root
        if os.path.basename(current_path) == target_root:
            return current_path
        current_path = os.path.dirname(current_path)
    print("Directory nebula-iii not found")
    return None  # Return None if "nebula-iii" is not found

def get_teams(root_directory):
    team_folders = glob.glob(root_directory + "/verilog/rtl/team_projects/*")
    return [os.path.basename(team_folder) for team_folder in team_folders]


def main():
    
    # Find the nebula-iii directory
    root_directory = find_root_directory(os.getcwd())
    
    teams = get_teams(root_directory)
    print(f"Generating includes files using teams: {teams}")
    
    rtl_includes_file = root_directory + "/verilog/includes/includes.rtl.caravel_user_project"
    gl_includes_file = root_directory + "/verilog/includes/includes.gl.caravel_user_project"

    # Copy the global includes that are required by everyone (GPIO, LA, etc)
    with open(root_directory + "/verilog/includes/includes.rtl.global", 'r') as src:
        content = src.read()
    with open(rtl_includes_file, 'w') as f:
        f.write(content)
        f.write("\n")
        
    # Copy the global includes that are required by everyone (GPIO, LA, etc)
    with open(root_directory + "/verilog/includes/includes.gl.global", 'r') as src:
        content = src.read()
    with open(gl_includes_file, 'w') as f:
        f.write(content)
        f.write("\n")
        
    # Append the includes from each team
    for team in teams:
        with open(root_directory + f"/verilog/rtl/team_projects/{team}/includes", 'r') as src:
            content = src.read()
        with open(rtl_includes_file, 'a') as f:
            f.write(content)
            f.write("\n")
        with open(gl_includes_file, 'a') as f:
            f.write(f"-v $(USER_PROJECT_VERILOG)/gl/{team}.v")
            f.write("\n")
            
    
    
if __name__ == "__main__":
    main()