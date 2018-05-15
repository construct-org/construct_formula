construct
=========

Salt Formula to install and manage `Construct <https://github.com/construct-org/construct>`_.

See the full `Salt Formulas installation and usage instructions <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:

``construct``
-------------
Installs and configures Construct based on pillars.

``construct.install``
---------------------
Same as ``construct``.

``construct.uninstall_global``
------------------------------
Ensures construct is not installed in your global python site-packages.


Pillars
=======

.. code-block::

    construct:
        # Path to the construct_setup git repo
        # You should not need to override this.
        pip_install: git+git://github.com/construct-org/construct_setup.git

        # The version of Construct to install - tag or branch of git repo
        version: '0.1.19'

        # Path to construct yaml configuration file
        # You probably want to set this to a shared network config
        config: '\\\\shared\\path\\construct.yaml'

        # Optional: Python executable used to create construct virtualenv
        python_exe: 'C:\\python27\\python.exe'

        # Optional: Root directory of construct installs
        install_dir: 'C:\\construct'


Installing a specific version of Construct
==========================================

.. code-block:: console

    > salt '\*' state.apply construct.install pillar='{"construct":{"version": "0.1.19"}}'
