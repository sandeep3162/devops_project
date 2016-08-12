
node '*' {  
  class { 'apache':    
    default_mods => false, 
  }  

  include apache::mod::ssl  

  apache::vhost { '*-http':    
    servername      => 'devops.puppetagent*.com',    
    port            => '80',    
    docroot         => '/var/www/html/',    
    redirect_status => 'permanent',    
    redirect_dest   => 'https://devops.puppetagent*.com/',  
  }  

  apache::vhost { '*-https':    
    servername      => 'devops.puppetagent*.com',    
    port            => '443',    
    docroot         => '/var/www/html/',    
    ssl             => true,    
  }
}
