#!/bin/bash

# Loop through each email in all.txt and send all emails in bulk
while IFS= read -r email
do
  echo "Sending email to: $email" &
  
  # Send the email using Postfix with HTML content
  cat <<EOF | /usr/sbin/sendmail -t &
To: $email
From: noreply@ups.com
Subject: UPS Delivery Waiting
MIME-Version: 1.0
Content-Type: text/html

$(cat ups.html)
EOF

done < all.txt

# Wait for all background jobs (bulk send) to finish before proceeding
wait

# Wait for 1 hour after sending all emails
sleep 3600

echo "All emails sent."