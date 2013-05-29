// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This file is for matcher tests that rely on the names of various Dart types.
// These tests normally fail when run in minified dart2js, since the names will
// be mangled. This version of the file is modified to expect minified names.

import 'package:unittest/unittest.dart';

import 'test_common.dart';
import 'test_utils.dart';

// A regexp fragment matching a minified name.
final _minifiedName = r"[A-Za-z0-9]{1,3}";

void main() {
  initUtils();

  group('Core matchers', () {
    test('throwsFormatException', () {
      shouldPass(() { throw new FormatException(''); },
          throwsFormatException);
      shouldFail(() { throw new Exception(); },
          throwsFormatException,
          matches(
              r"Expected: throws an exception which matches FormatException +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match FormatException\."
              r"Actual: <Closure>"));
    });

    test('throwsArgumentError', () {
      shouldPass(() { throw new ArgumentError(''); },
          throwsArgumentError);
      shouldFail(() { throw new Exception(); },
          throwsArgumentError,
          matches(
              r"Expected: throws an exception which matches ArgumentError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match ArgumentError\."
              r"Actual: <Closure>"));
    });

    test('throwsRangeError', () {
      shouldPass(() { throw new RangeError(0); },
          throwsRangeError);
      shouldFail(() { throw new Exception(); },
          throwsRangeError,
          matches(
              r"Expected: throws an exception which matches RangeError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match RangeError\."
              r"Actual: <Closure(: \(dynamic\) => dynamic)?>"));
    });

    test('throwsNoSuchMethodError', () {
      shouldPass(() { throw new NoSuchMethodError(null, '', null, null); },
          throwsNoSuchMethodError);
      shouldFail(() { throw new Exception(); },
          throwsNoSuchMethodError,
          matches(
              r"Expected: throws an exception which matches NoSuchMethodError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match NoSuchMethodError\."
              r"Actual: <Closure(: \(dynamic\) => dynamic)?>"));
    });

    test('throwsUnimplementedError', () {
      shouldPass(() { throw new UnimplementedError(''); },
          throwsUnimplementedError);
      shouldFail(() { throw new Exception(); },
          throwsUnimplementedError,
          matches(
              r"Expected: throws an exception which matches "
                  r"UnimplementedError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match UnimplementedError\."
              r"Actual: <Closure(: \(dynamic\) => dynamic)?>"));
    });

    test('throwsUnsupportedError', () {
      shouldPass(() { throw new UnsupportedError(''); },
          throwsUnsupportedError);
      shouldFail(() { throw new Exception(); },
          throwsUnsupportedError,
          matches(
              r"Expected: throws an exception which matches UnsupportedError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match UnsupportedError\."
              r"Actual: <Closure(: \(dynamic\) => dynamic)?>"));
    });

    test('throwsStateError', () {
      shouldPass(() { throw new StateError(''); },
          throwsStateError);
      shouldFail(() { throw new Exception(); },
          throwsStateError,
          matches(
              r"Expected: throws an exception which matches StateError +"
              r"But:  exception " + _minifiedName + r":<Exception> "
                  r"does not match StateError\."
              r"Actual: <Closure(: \(dynamic\) => dynamic)?>"));
    });
  });

  group('Iterable Matchers', () {
    test('isEmpty', () {
      var d = new SimpleIterable(0);
      var e = new SimpleIterable(1);
      shouldPass(d, isEmpty);
      shouldFail(e, isEmpty,
          matches(r"Expected: empty +But: was " + _minifiedName + r":\[1\]\."));
    });

    test('contains', () {
      var d = new SimpleIterable(3);
      shouldPass(d, contains(2));
      shouldFail(d, contains(5),
          matches(
              r"Expected: contains <5> +"
              r"But: was " + _minifiedName + r":\[3, 2, 1\]\."));
    });
  });

  group('Feature Matchers', () {
    test("Feature Matcher", () {
      var w = new Widget();
      w.price = 10;
      shouldPass(w, new HasPrice(10));
      shouldPass(w, new HasPrice(greaterThan(0)));
      shouldFail(w, new HasPrice(greaterThan(10)),
          matches(
              r"Expected: Widget with a price that is a value greater than "
                  r"<10> +"
              r"But: price was <10>\."
              r"Actual: <Instance of '" + _minifiedName + r"'>"));
    });
  });
}