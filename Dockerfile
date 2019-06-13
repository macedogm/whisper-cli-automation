FROM node

RUN wget https://bitwiseshiftleft.github.io/sjcl/sjcl.js

COPY encryption.js encryption.js
COPY keys.txt keys.txt
COPY whisper-secrets.sh whisper-secrets.sh

RUN chmod 700 whisper-secrets.sh

ENTRYPOINT ["/whisper-secrets.sh"]
