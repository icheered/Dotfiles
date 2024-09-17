import sys

envString = sys.argv[1]
splitstring = envString.split("\n")

def parse_env(env_list):
    env_dict = {}
    key = None

    for line in env_list:
        line = line.strip()
        if not line:
            continue
        elif "Edit Delete" in line:
            continue
        elif not key:
            key = line
        else:
            env_dict[key] = line
            key = None

    return env_dict

parsed_envs = parse_env(splitstring)
for key, value in parsed_envs.items():
    print(f"{key}={value}")

