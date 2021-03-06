.. highlight:: shell

============
Contributing
============

Contributions are welcome, and they are greatly appreciated! Every little bit
helps, and credit will always be given.


Code of Conduct
---------------

Everyone interacting in the ``krotov`` project's code base,
issue tracker, and any communication channels is expected to follow the
`PyPA Code of Conduct`_.

.. _`PyPA Code of Conduct`: https://www.pypa.io/en/latest/code-of-conduct/


Report Bugs
-----------

Report bugs at https://github.com/qucontrol/krotov/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.


Submit Feedback
---------------

The best way to send feedback is to file an issue at https://github.com/qucontrol/krotov/issues.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions
  are welcome :)


Pull Request Guidelines
-----------------------

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated. Put
   your new functionality into a function with a docstring, and add the
   feature to the list in ``docs/04_features.rst`` and/or ``HISTORY.rst``.
3. Check https://travis-ci.org/qucontrol/krotov/pull_requests
   and make sure that the tests pass for all supported Python versions.


Get Started!
------------

Ready to contribute? Follow `Aaron Meurer's Git Workflow Notes`_ (with ``qucontrol/krotov`` instead of ``sympy/sympy``)

In short, if you are not a member of the `qucontrol organization`_,

1. Clone the repository from ``git@github.com:qucontrol/krotov.git``
2. Fork the repo on GitHub to your personal account.
3. Add your fork as a remote.
4. Pull in the latest changes from the master branch.
5. Create a topic branch.
6. Make your changes and commit them (testing locally).
7. Push changes to the topic branch on *your* remote.
8. Make a pull request against the base master branch through the Github website of your fork.

The project contains a ``Makefile`` to help with development tasks. In your checked-out clone, do

.. code-block:: console

    $ make help

to see the available make targets.

If you are a member of the `qucontrol organization`_, there is no need to fork
``krotov`` - you can directly pull and push to ``git@github.com:qucontrol/krotov.git``.

It is strongly recommended that you use the conda_ package manager. The
``Makefile`` relies on conda to create local testing and documentation building
environments (``make test`` and ``make docs``).

Alternatively, you may  use ``make develop-test`` and ``make develop-docs`` to
run the tests or generate the documentation within your active Python
environment. You will have to ensure that all the necessary dependencies are
installed. Also, you will not be able to test the package against all supported
Python versions.
You still can (and should) look at https://travis-ci.org/qucontrol/krotov/ to check that your commits pass all tests.


.. _conda: https://conda.io/docs/

.. _Aaron Meurer's Git Workflow Notes:  https://www.asmeurer.com/git-workflow/

.. _qucontrol organization: https://github.com/qucontrol


.. _BranchingModel:

Branching Model
---------------

For developers with direct access to the repository,
``krotov`` uses a simple branching model where all
developments happens directly on the ``master`` branch. Releases are tags on
``master``. All commits on ``master`` *should* pass all tests and be
well-documented. This is so that ``git bisect`` can be effective. For any
non-trivial issue, it is recommended to create a topic branch, instead of
working on ``master``. There are no restrictions on commits on topic branches,
they do not need to contain complete documentation, pass any tests, or even be
able to run.

To create a topic-branch named ``issue1``::

    $ git branch issue1
    $ git checkout issue1

You can then make commits, and push them to Github to trigger Continuous
Integration testing::

    $ git push -u origin issue1

Commit early and often! At the same time, try to keep your topic branch
as clean and organized as possible. If you have not yet pushed your topic
branch to the "origin" remote:

* Avoid having a series of meaningless granular commits like "start bugfix",
  "continue development", "add more work on bugfix", "fix typos", and so forth.
  Instead, use ``git commit --amend`` to add to your previous commit. This is
  the ideal way to "commit early and often". You do not have to wait until a
  commit is "perfect"; it is a good idea to make hourly/daily "snapshots" of
  work in progress. Amending a commit also allows you to change the commit
  message of your last commit.
* You can combine multiple existing commits by "squashing" them. For example,
  use ``git rebase -i HEAD~4`` to combined the previous four commits into one.
  See the `"Rewriting History" section of Pro Git book`_ for details (if you
  feel this is too far outside of your git comfort zone, just skip it).
* If you work on a topic branch for a long time, and there is significant work
  on ``master`` in the meantime, periodically rebase your topic branch on the
  current master (``git rebase master``). Avoid merging ``master`` into your
  topic branch. See `Merging vs. Rebasing`_.

If you have already pushed your topic branch to the remote origin, you have to
be a bit more careful. If you are sure that you are the only one working on
that topic branch, you can still follow the above guidelines, and force-push
the issue branch (``git push --force``). This also applies if you are an
external contributor preparing a pull request in your own clone of the project.
If you are collaborating with others on the topic branch, coordinate with them
whether they are OK with rewriting the history. If not, merge instead of
rebasing. You must never rewrite history on the ``master`` branch (nor will you
be able to, as the ``master`` branch is "protected" and can only be force-pushed to
in coordination with the project maintainer).  If something goes wrong with any
advanced "history rewriting", there is always `"git reflog"`_ as a safety net
-- you will never lose work that was committed before.

When you are done with a topic branch (the issue has been fixed), finish up by
merging the topic branch back into ``master``::

    $ git checkout master
    $ git merge --no-ff issue1

The ``--no-ff`` option is critical, so that an explicit merge commit is created
(especially if you rebased).  Summarize the changes of the branch relative to
``master`` in the commit message.

Then, you can push master and delete the topic branch both locally and on Github::

    $ git push origin master
    $ git push --delete origin issue1
    $ git branch -D issue1

.. _"Rewriting History" section of Pro Git book: https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
.. _Merging vs. Rebasing: https://www.atlassian.com/git/tutorials/merging-vs-rebasing
.. _"git reflog": https://www.atlassian.com/git/tutorials/rewriting-history/git-reflog


Commit Message Guidelines
-------------------------

Write commit messages according to this template:

.. code-block:: none

    Short (50 chars or less) summary ("subject line")

    More detailed explanatory text. Wrap it to 72 characters. The blank
    line separating the summary from the body is critical (unless you omit
    the body entirely).

    Write your subject line in the imperative: "Fix bug" and not "Fixed
    bug" or "Fixes bug." This convention matches up with commit messages
    generated by commands like git merge and git revert. A properly formed
    git commit subject line should always be able to complete the sentence
    "If applied, this commit will <your subject line here>".

    Further paragraphs come after blank lines.

    - Bullet points are okay, too.
    - Typically a hyphen or asterisk is used for the bullet, followed by a
      single space. Use a hanging indent.

    You should reference any issue that is being addressed in the commit, as
    e.g. "#1" for issue #1. If the commit closes an issue, state this on the
    last line of the message (see below). This will automatically close the
    issue on Github as soon as the commit is pushed there.

    Closes #1

See `Closing issues using keywords`_ for details on references to issues that
Github will understand.


Testing
-------

The Krotov package includes a full test-suite using pytest_. We strive for a `test coverage`_ above 90%.

From a checkout of the ``krotov`` repository, assuming conda_ is installed, you can use

.. code-block:: console

    $ make test

to run the entire test suite.

The tests are organized in the ``tests`` subfolder. It includes python scripts
whose name start with ``test_``, which contain functions whose names also start
with ``test_``. Any such functions in any such files are picked up by `pytest`_
for testing. In addition, doctests_ from any docstring or any documentation
file (``*.rst``) are picked up (by the `pytest doctest plugin`_). Lastly, all
:ref:`example notebooks <ContributeExamples>` are validated as a test, through
the `nbval plugin`_.

.. _test coverage: https://coveralls.io/github/qucontrol/krotov?branch=master
.. _pytest: https://docs.pytest.org/en/latest/
.. _doctests: https://docs.python.org/3.7/library/doctest.html
.. _pytest doctest plugin: https://docs.pytest.org/en/latest/doctest.html
.. _nbval plugin: https://nbval.readthedocs.io/en/latest/


Code Style
----------

All code must be compatible with :pep:`8`. The line length limit
is 79 characters, although exceptions are permissible if this improves
readability significantly.

Beyond :pep:`8`, this project adopts the `Black code style`_, with
``--skip-string-normalization --line-length 79``. You can
run ``make black-check`` to check adherence to the code style, and
``make black`` to apply it.

.. _Black code style: https://github.com/ambv/black/#the-black-code-style

Imports within python modules must be sorted according to the isort_
configuration in ``setup.cfg``. The command ``make isort-check`` checks whether
all imports are sorted correctly, and ``make isort`` modifies all Python
modules in-place with the proper sorting.

.. _isort: https://github.com/timothycrosley/isort#readme

The code style is enforced as part of the test suite, as well as through git
pre-commit hooks that prevent committing code not does not meet the
requirements. These hooks are managed through the `pre-commit framework`_.

.. warning::
   After cloning the ``krotov`` repository, you must run
   ``make pre-commit-hooks``, or (if you have ``pre-commit`` installed)
   ``pre-commit install`` from within the project root folder.

.. _pre-commit framework: https://pre-commit.com

You may use ``make flake8-check`` and ``make pylint-check`` for additional
checks on the code with flake8_ and pylint_, but there is no strict requirement
for a perfect score with either one of these linters. They only serve as a
guideline for code that might be improved.

.. _flake8: http://flake8.pycqa.org
.. _pylint: http://pylint.pycqa.org


.. _write-documentation:

Write Documentation
-------------------

The ``krotov`` package could always use more documentation, whether
as part of the official docs, in docstrings, or even on the web in blog posts,
articles, and such.

The package documentation is generated with Sphinx_, the
documentation (and docstrings) are formatted using the
`Restructured Text markup language`_ (file extension ``rst``).
See also the `Matplotlib Sphinx cheat sheet`_ for some helpful tips.

Each function or class must have a docstring_; this docstring must
be written in the `"Google Style" format`_ (as implemented by
Sphinx' `napoleon extension`_). Docstrings and any other part of the
documentation can include `mathematical formulas in LaTeX syntax`_
(using mathjax_). In addition to Sphinx' normal syntax for inline math
(``:math:`x```), you may also use easier-to-read dollar signs (``$x$``).
The Krotov package defines some custom tex macros for quantum mechanics, which
you are strongly encouraged to use. These include:

* ``\bra``, e.g. ``$\bra{\Psi}$`` for :math:`\bra{\Psi}` (or ``\\Bra{}`` for auto-resizing).
  Do not use ``\langle``/``\rangle``/``\vert`` manually!
* ``\ket``, e.g. ``$\ket{\Psi}$`` for :math:`\ket{\Psi}` (or ``\Ket{}`` for auto-resizing).
* ``\Braket``, e.g. ``$\Braket{\Phi}{\Psi}$`` for :math:`\Braket{\Phi}{\Psi}`.
* ``\Op`` for quantum operators, e.g. ``$\Op{H}$`` for :math:`\Op{H}`.
* ``\Abs`` for absolute values, e.g. ``$\Abs{x}$`` for :math:`\Abs{x}`.
* ``\AbsSq``  for the absolute-square, e.g. ``$\AbsSq{\Braket{\Phi}{\Psi}}$`` for :math:`\AbsSq{\Braket{\Phi}{\Psi}}`.
* ``\avg`` for the expectation values, e.g. ``$\avg{\Op{H}}$`` for :math:`\avg{\Op{H}}` (or ``\Avg{}`` for auto-resizing).
* ``\Norm`` for the norm, e.g. ``$\Norm{\ket{\Psi}}$`` for :math:`\Norm{\ket{\Psi}}`.
* ``\identity`` for the identity operator, :math:`\identity`.
* ``\Liouville`` for the Liouvillian symbol, :math:`\Liouville`.
* ``\DynMap`` for the symbolic dynamical map, :math:`\DynMap`.
* ``\dd`` for the differential, e.g. ``$\int f(x) \dd x$`` for :math:`\int f(x) \dd x`.
* Function names / mathematical operators ``\tr``, ``\diag``, ``\abs``, ``\pop``.
* Text labels ``\aux``, ``\opt``, ``\tgt``, ``\init``, ``\lab``, ``\rwa``.

Also see :ref:`math-in-example-notebooks`.

You may use the BibTeX_ plugin for citations.

At any point, from a checkout of the ``krotov`` repository (and
assuming you have conda_ installed), you may run

.. code-block:: console

    $ make docs

to generate the documentation locally.

.. _Sphinx: http://www.sphinx-doc.org/en/master/
.. _Restructured Text markup language: http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
.. _docstring: https://www.python.org/dev/peps/pep-0257/
.. _"Google Style" format: http://www.sphinx-doc.org/en/master/usage/extensions/example_google.html#example-google
.. _napoleon extension: http://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html
.. _mathematical formulas in LaTeX syntax: http://www.sphinx-doc.org/en/1.6/ext/math.html
.. _mathjax: http://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.mathjax
.. _BibTeX: https://sphinxcontrib-bibtex.readthedocs.io/en/latest/
.. _Matplotlib Sphinx cheat sheet: https://matplotlib.org/sampledoc/cheatsheet.html

.. _ContributeExamples:

Contribute Examples
-------------------

Examples should be contributed in the form of `Jupyter notebooks`_.

.. _Jupyter notebooks: https://jupyter.readthedocs.io/en/latest/index.html

Example notebooks are automatically rendered as part of the documentation
(:ref:`krotov-example-notebooks`), and they are also verified by the automated
tests. For this to work properly, the following steps must be taken:

* Put all imports near the top of the notebook, with ``# NBVAL_IGNORE_OUTPUT``
  as the first line. Use the `watermark`_ package to print out the versions of
  imported packages. For example::

    # NBVAL_IGNORE_OUTPUT
    %load_ext watermark
    import qutip
    import numpy as np
    import scipy
    import matplotlib
    import matplotlib.pylab as plt
    %watermark -v --iversions

* Put the notebook in the folder ``docs/notebooks/``.

* Before committing, re-evaluate all example notebooks in a well-defined
  virtual environment by running

    .. code-block:: console

        $ make notebooks

* Check that the examples can be verified across different Python version by running

    .. code-block:: console

        $ make test

* You may also verify that the example is properly integrated in the documentation by running

    .. code-block:: console

        $ make docs


.. _math-in-example-notebooks:

Math in Example Notebooks
~~~~~~~~~~~~~~~~~~~~~~~~~

You may use the same tex macros described in the :ref:`write-documentation` section.
However, for the macros to work when viewing the notebook by itself, they must
be redefined locally. To this end, add a markdown cell underneath the top cell
that contains the imported packages (see above). The cell must contain the following:

.. code-block:: tex

    $\newcommand{tr}[0]{\operatorname{tr}}
    \newcommand{diag}[0]{\operatorname{diag}}
    \newcommand{abs}[0]{\operatorname{abs}}
    \newcommand{pop}[0]{\operatorname{pop}}
    \newcommand{aux}[0]{\text{aux}}
    \newcommand{opt}[0]{\text{opt}}
    \newcommand{tgt}[0]{\text{tgt}}
    \newcommand{init}[0]{\text{init}}
    \newcommand{lab}[0]{\text{lab}}
    \newcommand{rwa}[0]{\text{rwa}}
    \newcommand{bra}[1]{\langle#1\vert}
    \newcommand{ket}[1]{\vert#1\rangle}
    \newcommand{Bra}[1]{\left\langle#1\right\vert}
    \newcommand{Ket}[1]{\left\vert#1\right\rangle}
    \newcommand{Braket}[2]{\left\langle #1\vphantom{#2} \mid #2\vphantom{#1}\right\rangle}
    \newcommand{op}[1]{\hat{#1}}
    \newcommand{Op}[1]{\hat{#1}}
    \newcommand{dd}[0]{\,\text{d}}
    \newcommand{Liouville}[0]{\mathcal{L}}
    \newcommand{DynMap}[0]{\mathcal{E}}
    \newcommand{identity}[0]{\mathbf{1}}
    \newcommand{Norm}[1]{\lVert#1\rVert}
    \newcommand{Abs}[1]{\left\vert#1\right\vert}
    \newcommand{avg}[1]{\langle#1\rangle}
    \newcommand{Avg}[1]{\left\langle#1\right\rangle}
    \newcommand{AbsSq}[1]{\left\vert#1\right\vert^2}
    \newcommand{Re}[0]{\operatorname{Re}}
    \newcommand{Im}[0]{\operatorname{Im}}$

Upon executing the cell the definitions will be hidden, but the defined macros
will be available in any cell in the rest of the notebook.

.. _watermark: https://github.com/rasbt/watermark

Versioning
----------

Releases should follow `Semantic Versioning`_, and version numbers published to
PyPI_ must be compatible with :pep:`440`.

In short, versions number follow the pattern `major.minor.patch`, e.g.
``0.1.0`` for the first release, and ``1.0.0`` for the first *stable* release.
If necessary, pre-release versions might be published as e.g:

.. code-block:: none

    1.0.0-dev1  # developer's preview 1 for release 1.0.0
    1.0.0-rc1   # release candidate 1 for 1.0.0

Errors in the release metadata or documentation only may be fixed in a
post-release, e.g.:

.. code-block:: none

    1.0.0.post1  # first post-release after 1.0.0

Post-releases should be used sparingly, but they are acceptable even though
they are not supported by the `Semantic Versioning`_ specification.

The current version is available through the ``__version__`` attribute of the
:mod:`krotov` package:

.. doctest::

    >>> import krotov
    >>> krotov.__version__   # doctest: +SKIP

Between releases, ``__version__`` on the master branch should either be the
version number of the last release, with "+dev" appended (as a
`"local version identifier"`_), or the version number of the next planned
release, with "-dev" appended (`"pre-release identifier"`_ with extra dash).
The version string "1.0.0-dev1+dev" is a valid value after the "1.0.0-dev1"
pre-release. The "+dev" suffix must never be included in a release to PyPI_.

Note that twine_ applies normalization_ to the above recommended forms to
make them strictly compatible with :pep:`440`, before uploading to PyPI_. Users
installing the package through pip_ may use the original version specification
as well as the normalized one (or any other variation that normalizes to the
same result).

When making a release via

.. code-block:: shell

    $ make release

the above versioning conventions will be taken into account automatically.

Releases must be tagged in git, using the version string prefixed by "v",
e.g. ``v1.0.0-dev1`` and ``v1.0.0``. This makes them available at
https://github.com/qucontrol/krotov/releases.

.. _Semantic Versioning: https://semver.org
.. _"local version identifier": https://www.python.org/dev/peps/pep-0440/#local-version-identifiers
.. _"pre-release identifier": https://www.python.org/dev/peps/pep-0440/#pre-releases
.. _normalization: https://legacy.python.org/dev/peps/pep-0440/#id29
.. _PyPI: http://pypi.org
.. _twine: https://twine.readthedocs.io/en/latest/
.. _pip: https://pip.readthedocs.io/en/stable/


Developers' How-Tos
-------------------

The following assumes your current working directory is a checkout of
``krotov``, and that you have successfully run ``make test`` (which creates
some local virtual environments that development relies on).


How to install QuTiP from source ("illegal instruction" in QuTiP conda install)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The local conda environments that ``make test`` and other ``make`` targets set
up in the ``.venv`` folder use pre-compiled ``conda`` packages for QuTiP by
default. Unfortunately, some of QuTiP's conda packages are compiled
incorrectly, and crash the entire Python process whenever the ``qutip`` package
is imported (QuTiP issues `#951 <QutipIssue951_>`_, `#920 <QutipIssue920_>`_,
and `#674 <QutipIssue674_>`_). You will see a message like "Illegal
instruction" or something similar. This problem happens especially on Linux and
sometimes other Unixes (like macOS). Luckily, on Linux you will usually have
the necessary compilers to install QuTiP "from source" (via ``pip``). To enable
automatic installation via ``pip``, make the following changes to the
``Makefile``:

* Un-comment the line::

      CONDA_PACKAGES = cython numpy scipy

  near the top of the ``Makefile``. Defining ``CONDA_PACKAGES`` as above will
  ensure that the necessary build-requirements for QuTiP are available in the
  conda environment.

* Comment out all lines similar to::

      @conda install -y --override-channels -c defaults -c conda-forge -p .venv/py37 qutip

  By omitting this line, the ``Makefile`` will instead pick up the ``qutip``
  dependency automatically from ``setup.py`` in the command following in the next
  line::

      .venv/py37/bin/python -m pip install -e .[dev]

 This change is necessary for all of the ``.venv`` environments.


.. _QutipIssue951: https://github.com/qutip/qutip/issues/951
.. _QutipIssue920: https://github.com/qutip/qutip/issues/920
.. _QutipIssue674: https://github.com/qutip/qutip/issues/674


How to run a jupyter notebook server for working on the example notebooks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A notebook server that is isolated to the proper testing environment can be started via the Makefile::

    $ make jupyter-notebook

This is equivalent to::

    $ .venv/py37/bin/jupyter notebook --config=/dev/null

You may run this with your own options, if you prefer. The
``--config=/dev/null`` guarantees that the notebook server is completely
isolated. Otherwise, configuration files from your home directly (see
`Jupyter’s Common Configuration system`_)  may influence the server. Of
course, if you know what you're doing, you may want this.

If you prefer, you may also use the newer jupyterlab::

    $ make jupyter-lab

How to convert an example notebook to a script for easier debugging
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Interactive debugging in notebooks is difficult. It becomes much easier if
you convert the notebook to a script first.  To convert a notebook to an
(I)Python script and run it with automatic debugging, execute e.g.::

    $ ./.venv/py37/bin/jupyter nbconvert --to=python --stdout docs/notebooks/01_example_transmon_xgate.ipynb > debug.py
    $ ./.venv/py37/bin/ipython --pdb debug.py

You can then also set a manual breakpoint by inserting the following line anywhere in the code::

    from IPython.terminal.debugger import set_trace; set_trace() # DEBUG


How to make ``git diff`` work for notebooks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install nbdime_ and run ``nbdime config-git --enable --global`` to `enable the git integration`_.

.. _nbdime: https://nbdime.readthedocs.io/en/latest/index.html
.. _enable the git integration: https://nbdime.readthedocs.io/en/latest/index.html#git-integration-quickstart


How to commit failing tests or example notebooks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The test-suite on the ``master`` branch should always pass without error. If you
would like to commit any example notebooks or tests that currently fail, as a
form of `test-driven development`_, you have two options:

*   Push onto a topic branch (which are allowed to have failing tests), see
    the :ref:`BranchingModel`. The failing tests can then be fixed by
    adding commits to the same branch.

*   Mark the test as failing. For normal tests, add a decorator::

        @pytest.mark.xfail

    See the `pytest documentation on skip and xfail`_ for details.

    For notebooks, the equivalent to the decorator is to add a comment to the
    first line of the failing cell, either::

        # NBVAL_RAISES_EXCEPTION

    (preferably), or::

        # NBVAL_SKIP

    (this may affect subsequent cells, as the marked cell is not executed at all).
    See the `documentation of the nbval pluging on skipping and exceptions`_ for details.


How to run a subset of tests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To run e.g. only the tests defined in ``tests/test_krotov.py``, use::

    $ ./.venv/py37/bin/pytest tests/test_krotov.py

See the `pytest test selection docs`_ for details.

How to run only as single test
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Decorate the test with e.g. ``@pytest.mark.xxx``, and then run, e.g::

    $ ./.venv/py37/bin/pytest -m xxx tests/

See the `pytest documentation on markers`_ for details.

How to run only the doctests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run the following::

$ ./.venv/py37/bin/pytest --doctest-modules src

How to go into an interactive debugger
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Optionally, install the `pdbpp` package into the testing environment, for a
better experience::

    $ ./.venv/py37/bin/python -m pip install pdbpp

Then:

- before the line where you went to enter the debugger, insert a line::

    from IPython.terminal.debugger import set_trace; set_trace() # DEBUG

- Run ``pytest`` with the option ``-s``, e.g.::

    $ ./.venv/py37/bin/pytest -m xxx -s tests/

You may also see the `pytest documentation on automatic debugging`_.


How to see the debug logger output in the example notebooks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :func:`.optimize_pulses` routine generates some logger messages for
debugging purposes. To see these messages, set the level of "krotov" logger to
INFO or DEBUG:

.. code-block:: python

   import logging
   logger = logging.getLogger('krotov')
   logger.setLevel(logging.DEBUG)


You can also configure the logger with custom formatters, e.g. to show the
messages with time stamps:

.. code-block:: python

   ch = logging.StreamHandler()
   ch.setLevel(logging.INFO)
   formatter = logging.Formatter("%(asctime)s:%(message)s")
   ch.setFormatter(formatter)
   logger.addHandler(ch)
   logging.getLogger().handlers = [] # disable root handlers


See the `Configure Logging`_ section of the Python documentation for more details.


How to use quantum mechanical tex macros
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For docstrings or ``*.rst`` files, see :ref:`write-documentation`. For notebooks, see :ref:`math-in-example-notebooks`.


.. _Jupyter’s Common Configuration system: https://jupyter-notebook.readthedocs.io/en/stable/config_overview.html#jupyter-s-common-configuration-system
.. _Closing issues using keywords: https://help.github.com/articles/closing-issues-using-keywords/
.. _pytest test selection docs: https://docs.pytest.org/en/latest/usage.html#specifying-tests-selecting-tests
.. _pytest documentation on markers: https://docs.pytest.org/en/latest/example/markers.html
.. _pytest documentation on automatic debugging: https://docs.pytest.org/en/latest/usage.html#dropping-to-pdb-python-debugger-on-failures
.. _test-driven development: https://en.wikipedia.org/wiki/Test-driven_development
.. _pytest documentation on skip and xfail: https://docs.pytest.org/en/latest/skipping.html
.. _documentation of the nbval pluging on skipping and exceptions: https://nbval.readthedocs.io/en/latest/#Skipping-specific-cells
.. _Configure Logging: https://docs.python.org/3/howto/logging.html#configuring-logging
