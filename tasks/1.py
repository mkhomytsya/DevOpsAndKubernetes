import base64

# Define an array of strings representing the steps in a software development lifecycle
steps = ["plan", "code", "test", "delivery", "deploy", "monitor"]

# Loop through each step in the array and perform an operation
for step in steps:
    # Encode the current step as base64
    encoded_step = base64.b64encode(step.encode('utf-8'))
    print(encoded_step)