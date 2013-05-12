#!/home/y/bin/perl -w

# yinst  i perl-DBIx-DWIW

use strict;
use DBIx::DWIW;
$| = 1;  #flush output

my $db_host = 'hostname.com';
my $pass = 'password';
my $db_name = 'codereview';
my $user = 'codereview';

my $db = DBIx::DWIW->Connect(
                                 DB   => $db_name,
                                 User => $user,
                                 Pass => $pass,
                                 Host => $db_host
                                 );

if ($@) {die $@;};

my @reviewArray = $db->Hashes("
select 
  auth_user.username,
  REPLACE(reviews_reviewrequest.summary, "\n", " "),
  "codereview:comment",
  unix_timestamp(timestamp)
  from reviews_review, auth_user, reviews_reviewrequest
 where
reviews_review.user_id = auth_user.id
and  reviews_reviewrequest.id = reviews_review.review_request_id
limit 10
");

if ($@) {die $@;};

foreach my $row (@reviewArray)
{
    print $row->{"username"}, "\n";
}
