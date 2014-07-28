from setuptools import setup

setup(name="tmux_t",
      version="0.1.0",
      description="t, The simple tmux helper.",
      url="https://github.com/giodamelio/t",
      author="Gio d'Amelio",
      author_email="giodamelio@gmail.com",
      scripts=["t"],
      install_requires=[
          "tmuxp",
      ],
      license="MIT",
      zip_safe=False)
