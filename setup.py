import os
import json
import zipfile
import shutil

def replace_variables(script_path, params):
    with open(script_path, 'r') as file:
        script_content = file.read()

    for key, value in params.items():
        script_content = script_content.replace(f'@@{key}@@', value)

    with open(script_path, 'w') as file:
        file.write(script_content)

def unpack_setup_zip(zip_file, target_dir):
    with zipfile.ZipFile(zip_file, 'r') as zip_ref:
        zip_ref.extractall(target_dir)

def create_directories_from_params(params):
    for key, value in params.items():
        if "DIR" in key:
            dir_path = os.path.abspath(os.path.expanduser(value))
            os.makedirs(dir_path, exist_ok=True)

def add_current_directory_to_path():
    current_directory = os.getcwd()
    if current_directory not in sys.path:
        sys.path.append(current_directory)
        os.environ['PATH'] = os.pathsep.join([current_directory, os.environ['PATH']])

def add_path_to_system():
    if os.geteuid() == 0:  # Check if the current user is root (sudo)
        current_directory = os.getcwd()
        with open('/etc/environment', 'r') as env_file:
            env_content = env_file.read()
        if current_directory not in env_content:
            with open('/etc/environment', 'a') as env_file:
                env_file.write(f':{current_directory}')
    else:
        print("This operation requires administrative privileges.")
        # Ask for sudo password to add path to system
        os.system(f'sudo sh -c "echo \':{current_directory}\' >> /etc/environment"')

def modify_python_scripts(src_dir, json_content):
    for filename in os.listdir(src_dir):
        if filename.endswith('.py'):
            script_path = os.path.join(src_dir, filename)

            with open(script_path, 'r') as file:
                script_content = file.read()

            for entry in json_content:
                parameters = entry['parameters']
                for key, value in parameters.items():
                    script_content = script_content.replace(f'@@{key}@@', value)

            with open(script_path, 'w') as file:
                file.write(script_content)

def main():
    json_file = 'setup.ini'
    setup_zip_file = 'setup.zip'
    target_dir = 'setup_scripts'
    src_dir = 'setup_src'
    current_dir = os.getcwd()

    # Create the setup_scripts directory if it doesn't exist
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    # Create the setup_src directory if it doesn't exist
    if not os.path.exists(src_dir):
        os.makedirs(src_dir)

    # Unpack the setup.zip and copy setup_*.sh and setup_*.py files to setup_src directory
    unpack_setup_zip(setup_zip_file, target_dir)

    with open(json_file, 'r') as file:
        json_content = json.load(file)

    for filename in os.listdir(target_dir):
        if filename.startswith('setup_') and (filename.endswith('.sh') or filename.endswith('.py')):
            script_path = os.path.join(target_dir, filename)
            # Copy original file to setup_src directory
            shutil.copy(script_path, os.path.join(src_dir, filename))

            # Modify the names of processed files
            new_filename = filename.replace('setup_', '')
            new_script_path = os.path.join(current_dir, new_filename)

            for entry in json_content:
                if entry['script'] == filename:
                    parameters = entry['parameters']
                    create_directories_from_params(parameters)
                    replace_variables(script_path, parameters)
                    break

            # Copy processed file to the current directory
            shutil.copy(script_path, new_script_path)

    # Clean up the setup_scripts directory
    shutil.rmtree(target_dir)

    # Modify the variables in Python scripts
    modify_python_scripts(src_dir, json_content)

if __name__ == "__main__":
    main()

