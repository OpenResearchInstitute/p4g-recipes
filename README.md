# p4g-recipes
Locked-down revisions of GNU Radio &amp; friends for use by phase4ground

GNU Radio is a complicated beast with a lot of dependencies. There are a number of ways
to acquire a working version:
 * Use the version that comes with your Linux distribution (probably way older than what you want)
 * Use the [magic build-gnuradio script by Marcus Leech](https://wiki.gnuradio.org/index.php/InstallingGRFromSource), which
 works great, but it's hard to predict what you will end up with
 * Use [PyBOMBS](https://www.gnuradio.org/blog/pybombs-the-what-the-how-and-the-why), which is a package manager especially 
 for GNU Radio.

 More information on all of these options is available [here](https://wiki.gnuradio.org/index.php/InstallingGRFromSource).

While PyBOMBS makes installing GNU Radio and its many dependencies a lot easier, it still suffers from a fundamental problem: It is very hard to build the same thing twice. Why is that? For each package that is installed through PyBOMBS, there is a recipe. A recipe is a file that tells PyBOMBS about specific packages, and how to acquire the source code for them. Which version of 
the source code? That is exactly the problem. There are a few "standard collections" of recipes
that people tend to use:
* [gr-recipes](https://github.com/gnuradio/gr-recipes.git)
* [gr-etcetera](https://github.com/gnuradio/gr-etcetera.git)

and probably a few others. While these recipes are very useful, the versions that they specify are probably not what you want. For example, the default [gnuradio recipe](https://github.com/gnuradio/gr-recipes/blob/master/gnuradio.lwr) specifies its version as follows:

```
source: git+https://github.com/gnuradio/gnuradio.git
gitbranch: master
```
So it will select whatever the latest commit of the master branch of the gnuradio source repository is. So if you build gnuradio from this recipe tomorrow, you will probably get a a different version
than what you built today, because chances are that somebody made some changes that you will pick
up, whether you want to or not. This causes huge inefficiencies if you want to deploy the exact 
same version of code onto a different development machine, deployment target, or do collaborative
developement and testing with other individuals. 

This is the problem that this repository is trying to solve. Luckily, the PyBOBMBS recipe syntax 
allows for all sorts of ways to specify exact versions. So by adapting the recipes to request 
specific versions for specific components, it is possible to create a 'meta-version' that can
be built repeatably, and end up with the same code at different points in time.

So we can replace the lines above with
```
source: git+https://github.com/gnuradio/gnuradio.git
gitrev: tags/3.7.11
```
and regardless of when we build this, it is going to retrieve the source code for version 3.7.11.

Note that this problem is too big to be solved compeletely. For example, if I build the same version
of GNU Radio on an embedded Linux on an ARM processor, or on a desktop machine running Ubuntu 14.04,
there will be many different OS libraries that the code will link against, and chances are that they
will be different versions also. This effort is about 
locking down the versions just enough, so that the differences are no longer a problem.

## How to bootstrap this
We are just starting to do this, so there are no official "known good" versions yet. Bear with us
while we are spinning this up. So far, the list of recipes is rather short. The first order of the
day is to build something reasonably stable that works with the ADALM-PLUTO. Take a look at the
lwr files to see which version is selected for each of the components included.

First you want to set up a sandbox to play in, so you don't have to modify the Python installation
on your system (if something goes wrong there, it can be hard to recover from). Luckily there
is a tool to help with that, called `virtualenv`. It lets you create a Python environemnt that is 
isolated from the main site packages directory. Install it from your package manager, e.g. on
Ubuntu:

```
sudo apt-get install virtualenv
```

Once that is done, create a directory, and have `virtualenv` create a new environemnt for
you:
```
mkdir ~/sandbox
virtualenv ~/sandbox/gr
```
Then cd into your new environment, and activate it:
```
cd ~/sandbox/gr
source bin/activate
```
Notice how the prompt changes to show the active environment.

Now you can install pybombs:
```
pip install pybombs
```


Build this by running `build.sh` from the command line.