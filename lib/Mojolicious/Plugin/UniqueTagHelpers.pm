package Mojolicious::Plugin::UniqueTagHelpers;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

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

Mojolicious::Plugin::UniqueTagHelpers - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('UniqueTagHelpers');

  # Mojolicious::Lite
  plugin 'UniqueTagHelpers';

=head1 DESCRIPTION

L<Mojolicious::Plugin::UniqueTagHelpers> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::UniqueTagHelpers> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
