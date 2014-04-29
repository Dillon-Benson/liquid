require 'test_helper'

class TemplateUnitTest < Test::Unit::TestCase
  include Liquid

  def test_sets_default_localization_in_document
    t = Template.new
    t.parse('')
    assert_instance_of I18n, t.root.options[:locale]
  end

  def test_sets_default_localization_in_context_with_quick_initialization
    t = Template.new
    t.parse('{{foo}}', :locale => I18n.new(fixture("en_locale.yml")))

    assert_instance_of I18n, t.root.options[:locale]
    assert_equal fixture("en_locale.yml"), t.root.options[:locale].path
  end

  def test_render_bang_raises_if_context_is_passed_and_it_does_not_have_rethrow_errors
    t = Template.new.parse('')
    context = Context.new

    refute context.rethrow_errors
    e = assert_raises ArgumentError do
      t.render!(context)
    end
    assert_equal 'Unable to set rethrow error policy on a context provided as parameter', e.message
  end
end
