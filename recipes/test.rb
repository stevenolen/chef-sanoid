sanoid_template 'default2' do
  hourly 30
  daily 1
  monthly 1
  yearly 1
  autosnap "yes"
  autoprune "yes"
end

sanoid_dataset 'zfs/test' do
  use_template "default"
end

sanoid_template 'default' do
  hourly 30
  daily 1
  monthly 1
  yearly 1
  autosnap "yes"
  autoprune "yes"
end