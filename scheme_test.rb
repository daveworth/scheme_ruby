require 'test/unit'
load 'scheme.rb'

class TestSchemeObjectAtom < Test::Unit::TestCase
  def test_symbol_is_atom
    assert :symbol.atom?
  end

  def test_string_is_atom
    assert "foo".atom?
  end

  def test_numerics_are_atoms
    assert 1.34.atom?
  end

  def test_lists_are_not_atoms
    assert ![].atom?
  end
end

class TestSchemeObjectSExpr < Test::Unit::TestCase
  def test_atoms_are_sexprs
    assert :symbol.sexpr?
  end

  def tests_lists_are_sexprs
    assert [].sexpr?
  end
end

class TestSchemeArrayListPredicate < Test::Unit::TestCase
  def test_empty_lists_are_lists
    assert [].list?
  end

  def test_flat_arrays_of_atoms_are_lists
    assert [:a, "string and a", 3.14].list?
  end

  def test_deeply_nested_arrays_of_atoms_are_lists
    assert [[:a, "different"], "type", [:of, 3.14]].list?
  end

  def test_atoms_are_not_lists
    assert_raise(NoMethodError) { :a.list? }
  end
end

class TestSchemeArrayNullPredicate < Test::Unit::TestCase
  def test_empty_is_null
    assert [].null?
  end

  def test_not_empty_is_not_null
    assert ![:foo].null?
  end

  def test_null_of_atom_undefined
    assert(NoMethodError) { :a.null? }
  end
end

class TestSchemeDeconstruction < Test::Unit::TestCase
  def test_car_of_atom_undefined
    assert(NoMethodError) { :a.car }
  end

  def test_car_of_list
    assert_equal :a, [:a, :b].car
  end

  def test_cdr_of_list
    assert_equal [:b], [:a, :b].cdr
  end

  def test_crazy_dynamic_decomposition
    assert_equal :d, [[], [[:b,:c,:d]]].caddaadr
  end
end

class TestSchemeListConstruction < Test::Unit::TestCase
  def test_cons_atom_to_list
    assert_equal [:a, :b, :c], [:b, :c].cons(:a)
  end
end

class TestSchemeListOfAtoms < Test::Unit::TestCase
  def test_empty_list
    assert [].lat?
  end

  def test_flat_list_of_atoms
    assert [:a, "list", 3.14].lat?
  end

  def test_deep_list_is_not_a_list_of_atoms
    assert ![[:a], :b, "list", 3.14].lat?
  end
end
