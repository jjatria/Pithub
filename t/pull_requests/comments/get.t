use FindBin;
use lib "$FindBin::Bin/../../lib";
use Pithub::Test;
use Test::Most;

BEGIN {
    use_ok('Pithub::PullRequests::Comments');
}

my $obj = Pithub::Test->create( 'Pithub::PullRequests::Comments', user => 'foo', repo => 'bar' );

isa_ok $obj, 'Pithub::PullRequests::Comments';

throws_ok { $obj->get } qr{Missing key in parameters: comment_id}, 'No parameters';

{
    my $result = $obj->get( comment_id => 456 );
    is $result->request->method, 'GET', 'HTTP method';
    is $result->request->uri->path, '/repos/foo/bar/pulls/comments/456', 'HTTP path';
    my $http_request = $result->request->http_request;
    is $http_request->content, '', 'HTTP body';
}

done_testing;