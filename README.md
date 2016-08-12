DevOps Project:

Below is the procedure which I followed to accomplish the given project.

	I.  Initially I created an ubuntu instance in AWS.
	II. Installed open source puppetmaster in it.
	III.Installed the AWS module
	IV. Installed sdk gems 
	V.  For AWS access credentials I have set the AWSaccesskeyID and AWSsecretaccesskey.

Steps to create above scenarios:

1. Install the retries gem and the Amazon AWS Ruby SDK gem.
	a. If you're using open source Puppet, the SDK gem should be installed into the 
	same Ruby used by Puppet. Install the gems with these commands: 
	
			gem install aws-sdk-core gem install retries
			
	b.If you're running Puppet Enterprise, install both the gems with this command:
	
			cd /opt/puppet/bin/gem install aws-sdk-core retries
	
	c.If you're running Puppet Enterprise 2015.2.0 or newer, install both the gems 
	with this command: 
	
			/opt/puppetlabs/puppet/bin/
			gem install aws-sdk-core retries
			
	This allows the gems to be used by the Puppet Enterprise Ruby.

	d.If you're running Puppet Server, you need to make both gems available to JRuby
	 with:
 
 			/opt/puppet/bin/puppetserver 
 			gem install aws-sdk-core retries
 			
	Once the gems are installed, restart Puppet Server.

2. Set these environment variables for your AWS access credentials:

			export AWS_ACCESS_KEY_ID=your_access_key_id
			export AWS_SECRET_ACCESS_KEY=your_secret_access_key

	If you have Puppet running on AWS, and you're running the module examples, you can
 	instead use IAM. To do this, assign the correct role to the instance from which 
 	you're running the examples. For a sample profile with all the required permissions,
 	 see the IAM profile example.

3. Finally, install the module with:

			puppet module install puppetlabs-aws
			

Now installed the puppetlabs-aws module.

- I have wrote the init.pp to create two EC2 Instances, Security group, VPC, Elastic Load
Balancer, Subnet, Internet gateway and a user template of "apache-puppet.sh".
-Apache-Puppet.sh
	- Hostnames to the agents
	- Modify Permissions
	- Allocate Hostnames in Hostname file and Hosts file.
	- connection between Puppet agent and Puppet master.
- I have initiated it.
- I have wrote site.pp which configures 
	- Configures Apache
	- Configure HTTP
	- Configure HTTPS

This is how I accomplished the given Project.


-SANDEEP NAGULA
AWS Certified Solution Architect and SysOps Administrator
