#!/usr/bin/perl

use warnings;
use strict;
use DBI;

print "Content-type: text/html\n";

#Database connection...
my $sql="select * from dashboard";
my $dbh = DBI->connect('dbi:mysql:palo_alto','root','mysql123') or die "Connection Error: $DBI::errstr\n";
my $sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
#Database connection end...

print <<HTML;

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
Welcome
<div id="container">
<table border="1" cellspacing="1" bgcolor="#999999">
<tr><th>Admin</th><th>Session start time</th><th>Idle for</th><th>From</th><th>Type</th></tr>
HTML

while(my @rw=$sth->fetchrow_array())
{
my ($admin, $sstime, $idlef, $from, $type)=@rw;
print "<tr><td>$admin</td><td>$sstime</td><td>$idlef</td><td>$from</td><td>$type</td></tr>";
}

print <<HTML;

</table>
</div>
</body>
</html>

HTML
