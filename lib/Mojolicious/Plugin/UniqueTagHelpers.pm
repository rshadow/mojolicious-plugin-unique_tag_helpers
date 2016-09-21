package Mojolicious::Plugin::UniqueTagHelpers;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.02';

sub register {
    my ($self, $app) = @_;

    $app->helper(stylesheet_for => sub {
        my ($c, $name, $content) = @_;
        $name ||= 'content';

        my $hash = $c->stash->{'uniquetaghelpers.stylesheet'} ||= {};
        if( defined $content ) {
            $hash->{$name} ||= {};

            return $c->content( $name ) if exists $hash->{$name}{$content};

            $c->content_for( $name => $hash->{$name}{$content} =
                $c->stylesheet($content)
            );
        }
        return $c->content( $name );
    });

    $app->helper(javascript_for => sub {
        my ($c, $name, $content) = @_;
        $name ||= 'content';

        my $hash = $c->stash->{'uniquetaghelpers.javascript'} ||= {};
        if( defined $content ) {
            $hash->{$name} ||= {};

            return $c->content( $name ) if exists $hash->{$name}{$content};

            $c->content_for( $name => $hash->{$name}{$content} =
                $c->javascript($content)
            );
        }
        return $c->content( $name );
    });
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::UniqueTagHelpers - Mojolicious Plugin to use unique
javascript and stylesheet links.

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('UniqueTagHelpers');

  # Mojolicious::Lite
  plugin 'UniqueTagHelpers';

  stylesheet_for

=head1 DESCRIPTION

L<Mojolicious::Plugin::UniqueTagHelpers> is a HTML tag helpers for
javascript and stylesheet allowing multiple include in templates.

=head1 HELPERS

=head2 stylesheet_for

    @@ index.html.ep
    % layout 'default';
    % stylesheet_for 'header' => 'css/main.css';
    ...
    % include 'someblock'

    @@ someblock.html.ep
    ...
    % stylesheet_for 'header' => 'css/main.css';

    @@ layouts/default.html.ep
    <!DOCTYPE html>
    <html>
        <head>
            <title>MyApp</title>
            %= stylesheet_for 'header';
        </head>
        <body>
            <%= content %>
        </body>
    </html

This example generate only one link to F<css/main.css>:

    <!DOCTYPE html>
    <html>
        <head>
            <title>MyApp</title>
            <link href="css/main.css" rel="stylesheet" />
        </head>
        <body>
        </body>
    </html>

=head2 javascript_for

    @@ index.html.ep
    % layout 'default';
    % javascript_for 'footer' => 'js/main.js';
    ...
    % include 'someblock'

    @@ someblock.html.ep
    ...
    % javascript_for 'footer' => 'js/main.js';

    @@ layouts/default.html.ep
    <!DOCTYPE html>
    <html>
        <head>
            <title>MyApp</title>
        </head>
        <body>
            <%= content %>
            %= javascript_for 'footer';
        </body>
    </html

This example generate only one link to F<js/main.js>:

    <!DOCTYPE html>
    <html>
        <head>
            <title>MyApp</title>
        </head>
        <body>
            <script src="js/main.js"></script>
        </body>
    </html>

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<Mojolicious::Plugin::TagHelpers>,
L<http://mojolicio.us>.

=cut