## to get the bootstrap script
package "wget"

## make sure we have apt-add-repository
if node['platform_version'].to_f < 16
  package "python-software-properties"
end
package "software-properties-common"

url = "https://raw.github.com/progrium/dokku/#{node[:dokku][:tag]}/bootstrap.sh"

bash "dokku-bootstrap" do
  code "wget -qO- #{url} | sudo DOKKU_TAG=#{node[:dokku][:tag]} " +
    "DOKKU_ROOT=\"#{node[:dokku][:root]}\" bash"
end
