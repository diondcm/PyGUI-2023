unit PythonSource;

interface

resourcestring
  API_KEY_CONST = '#API-SECRET-KEY#';

  API_SECRET_KEY = 'YOUR_KEY';

  MY_SIMPLE_PY_APP =
    'import openai' +
    '' +
    '# Set up your OpenAI API key' +
    'openai.api_key = "#API-SECRET-KEY#"' +
    '' +
    'def chat_with_gpt(prompt):' +
    'response = openai.Completion.create(' +
    'engine=''text-davinci-003'',  # You can change the engine if needed' +
    'prompt=prompt,' +
    'max_tokens=50,  # Adjust the length of the response as desired' +
    'temperature=0.7,  # Controls the randomness of the response. Lower values make it more focused.' +
    'n=1,  # Number of responses to generate' +
    'stop=None,  # Specify a custom stop sequence if needed' +
    'timeout=15  # Timeout in seconds' +
    ')' +
    '' +
    'if ''choices'' in response and len(response.choices) > 0:' +
    'return response.choices[0].text.strip()' +
    'else:' +
    'return None' +
    '' +
    '# Example usage' +
    'response = chat_with_gpt("Short exercice description for people starting academy in one line")' +
    'if response:' +
    'print(''ChatGPT:'', response)' +
    'else:' +
    'print(''An error occurred.'')';


implementation

end.
