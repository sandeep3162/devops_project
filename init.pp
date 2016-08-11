ec2_vpc{ 'Web Host VPC':
ensure  => present,
region => 'us-east-1',
instance_tenancy => 'default',
cidr_block => '10.0.0.0/16',
}
ec2_vpc_subnet { 'Web Host Subnet' :
ensure => present,
vpc => 'Web Host VPC',
region => 'us-east-1',
availability_zone   => 'us-east-1a',
cidr_block => '10.0.0.0/24',
}
ec2_vpc_internet_gateway{ 'Web Host IG' :
ensure => present,
vpc => 'Web Host VPC',
region => 
}
ec2_vpc_routetable{ 'Web Host Route':
ensure => present,
vpc => 'Web Host VPC',
routes => [
    {
      destination_cidr_block => '10.0.0.0/16',
      gateway                => 'local'
    },{
      destination_cidr_block => '0.0.0.0/0',
      gateway                => 'Web Host IG'
    },
  ],
}  
ec2_securitygroup { 'Web Host Security':
  ensure      => present,
  region      => 'us-east-1',
  description => 'Security Purpose',
  subnet => 'Web Host Subnet',
  ingress     => [{
    protocol  => 'tcp',
    port      => 80,
    cidr      => '0.0.0.0/0',
  },{
    security_group => 'other-security-group',
    vpc => 'Web Host VPC',
  }],
  tags        => {
    tag_name  => 'value',
  },
}
ec2_instance { 'Web Host server1':
  ensure            => present,
  region            => 'us-east-1',
  availability_zone => 'us-east-1a',
  image_id          => 'ami-2d39803a',
  instance_type     => 't2.micro',
  monitoring        => true,
  key_name          => 'sample',
  security_groups   => ['Web Host Security'],
#  user_data         => template('module/file-path.sh.erb'),
#  tags              => {
#    tag_name => 'value',
#  },
}
ec2_instance { 'Web Host server2':
  ensure            => present,
  region            => 'us-east-1',
  availability_zone => 'us-east-1b',
  image_id          => 'ami-2d39803a',
  instance_type     => 't2.micro',
  monitoring        => true,
  key_name          => 'sample',
  security_groups   => ['Web Host Security'],
#  user_data         => template('module/file-path.sh.erb'),
#  tags              => {
#    tag_name => 'value',
#  },
}

elb_loadbalancer { 'Web Host load-balancer':
  ensure               => present,
  region               => 'us-east-1',
  availability_zones   => ['us-east-1a', 'us-east-1b'],
  instances            => ['Web Host server1', 'Web Host server2'],
  security_groups      => ['Web Host Security'],
  listeners            => [{
    protocol           => 'HTTP',
    load_balancer_port => 80,
    instance_protocol  => 'HTTP',
    instance_port      => 80,
  },{
    protocol           => 'HTTPS',
    load_balancer_port => 443,
    instance_protocol  => 'HTTPS',
    instance_port      => 8080,
    ssl_certificate_id => 'arn:aws:iam::123456789000:server-certificate/yourcert.com',
  }],
  tags                 => {
    tag_name => 'value',
  },
}