# Automated Minecraft Server Creation
In response to my son's persistent request for Minecraft servers, I undertook a creative tech project that seamlessly blends my skills 
in Terraform, AWS, Ansible, and Jenkins. The result is an automated pipeline that streamlines the entire process, from provisioning 
EC2 instances using Terraform and configuring them with Ansible to setting up the Minecraft server through Docker Compose. 
Once the pipeline completes, it sends an email containing the server's public IP address, enabling easy access for my son and his friends. 
Notably, I also integrated a user-triggered deployment mechanism via a secure URL, empowering my son to initiate the process independently. 
