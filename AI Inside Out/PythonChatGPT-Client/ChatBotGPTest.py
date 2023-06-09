import openai
from config import API_KEY

openai.api_key = API_KEY

response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
            {"role": "system", "content": "You are a chatbot"},
            {"role": "user", "content": "Why should DevOps engineer learn kubernetes?"},
        ]
)

result = ''
for choice in response.choices:
    result += choice.message.content

print(result)

import openai
import time

# Set up your OpenAI API key
openai.api_key = "YOUR_API_KEY_HERE"

# Define a message function to send a message to the GPT-3 model and retrieve the response
def message(prompt, model, engine, temperature=0.5, max_tokens=100):
    response = openai.Completion.create(
    engine=engine,
    prompt=prompt,
    max_tokens=max_tokens,
    temperature=temperature,
    n = 1,
    stop=None,
    )
    message = response.choices[0].text.strip()
    time.sleep(1) # Wait a second to avoid rate limits
    return message

# Use the message function to simulate a conversation
while True:
    user_input = input("You: ")
    if user_input.lower() == "stop":
        break
    response = message(prompt=f"You: {user_input}\nBot:", model="text-davinci-002", engine="davinci", temperature=0.5, max_tokens=100)
    print(f"Bot: {response}")

import openai
import time

# Set up your OpenAI API key
openai.api_key = "YOUR_API_KEY_HERE"

# Define a message function to send a message to the GPT-3 model and retrieve the response
def message(prompt, model, engine, temperature=0.5, max_tokens=100):
    response = openai.Completion.create(
    engine=engine,
    prompt=prompt,
    max_tokens=max_tokens,
    temperature=temperature,
    n = 1,
    stop=None,
    )
    message = response.choices[0].text.strip()
    time.sleep(1) # Wait a second to avoid rate limits
    return message

# Use the message function to simulate a conversation
while True:
    user_input = input("You: ")
    if user_input.lower() == "stop":
        break
    response = message(prompt=f"You: {user_input}\nBot:", model="text-davinci-002", engine="davinci", temperature=0.5, max_tokens=100)
    print(f"Bot: {response}")

