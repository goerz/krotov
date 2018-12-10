"""Test that we can serialize a Resuls object"""

import os
import pickle

import numpy as np

from krotov.result import Result


def test_serialization_roundtrip(request, tmpdir):
    testdir = os.path.splitext(request.module.__file__)[0]
    with open(os.path.join(testdir, 'oct_result.dump'), 'rb') as dump_fh:
        result = pickle.load(dump_fh)
        assert isinstance(result, Result)
    dumpfile = str(tmpdir.join('oct_result.dump'))
    with open(dumpfile, 'wb') as dump_fh:
        pickle.dump(result, dump_fh)
    with open(dumpfile, 'rb') as dump_fh:
        result2 = pickle.load(dump_fh)
    for name in result.__dict__:
        val1 = getattr(result, name)
        val2 = getattr(result2, name)
        _check_recursive_equality(val1, val2)


def _check_recursive_equality(val1, val2):
    if isinstance(val1, list):
        for (v1, v2) in zip(val1, val2):
            _check_recursive_equality(v1, v2)
    elif isinstance(val1, np.ndarray):
        assert np.all(val1 == val2)
    else:
        assert val1 == val2