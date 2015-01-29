requires "Carp" => "0";
requires "Date::Parse" => "0";
requires "DateTime" => "0";
requires "HTML::Form" => "0";
requires "HTTP::Request::Common" => "0";
requires "JSON" => "0";
requires "LWP::UserAgent" => "0";
requires "List::MoreUtils" => "0";
requires "Moo" => "0";
requires "Try::Tiny" => "0";
requires "namespace::clean" => "0";
requires "perl" => "5.006";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test::More" => "0";
  requires "Test::Most" => "0";
  requires "constant" => "0";
  requires "perl" => "5.006";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "perl" => "5.006";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::EOL" => "0";
  requires "Test::Kwalitee" => "1.21";
  requires "Test::More" => "0";
  requires "Test::NoTabs" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Synopsis" => "0";
};
