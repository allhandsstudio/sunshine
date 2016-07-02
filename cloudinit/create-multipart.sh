#!/bin/bash

write-mime-multipart \
  --output combined_userdata.txt \
  include.txt:text/x-include-url \
  user-script.sh:text/x-shellscript