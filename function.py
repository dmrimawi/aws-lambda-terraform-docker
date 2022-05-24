try:
    import os
    import subprocess
    import json
    import sys
    import requests
    print("All imports ok ...")
except Exception as e:
    print("Error Imports : {} ".format(e))


def lambda_handler(event, context):
    print("Received the event = {}".format(event))
    print("Creating platform started..")
    cmd = "app/create_platform.sh"
    print(f"Running command: {cmd}..")
    p = subprocess.Popen(cmd)
    out, err = p.communicate()
    print(f"Output: {out}")
    print(f"Error: {err}")
    print(f"RC = {p.returncode}")
    return {
        'statusCode': 200,
    }


