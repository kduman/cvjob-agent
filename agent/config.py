import os
from dotenv import load_dotenv

load_dotenv()

# Not used explicitly, but required for OpenAI API
# We're keeping them here for future convenience

OPENAI_ORGANIZATION = os.getenv("OPENAI_ORGANIZATION")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
