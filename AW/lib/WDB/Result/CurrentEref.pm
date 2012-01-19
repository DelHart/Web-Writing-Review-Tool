package WDB::Result::CurrentEref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WDB::Result::CurrentEref

=cut

__PACKAGE__->table("current_eref");

=head1 ACCESSORS

=head2 eref

  data_type: 'integer'
  is_nullable: 1

=head2 revision

  data_type: 'integer'
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=head2 date_created

  data_type: 'integer'
  is_nullable: 1

=head2 utility

  data_type: 'text'
  is_nullable: 1

=head2 url

  data_type: 'text'
  is_nullable: 1

=head2 nickname

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "eref",
  { data_type => "integer", is_nullable => 1 },
  "revision",
  { data_type => "integer", is_nullable => 1 },
  "essay",
  { data_type => "integer", is_nullable => 1 },
  "date_created",
  { data_type => "integer", is_nullable => 1 },
  "utility",
  { data_type => "text", is_nullable => 1 },
  "url",
  { data_type => "text", is_nullable => 1 },
  "nickname",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-20 15:32:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DF1D7dd7pA9XKJJh1WEkYw

__PACKAGE__->set_primary_key("eref", "essay");

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
