# Jabba's ZSH settings

This repo contains my own ZSH settings.

For putting my settings together, I used
lots of resources (see links below).

First I tried oh-my-zsh. It was great. It has a very
logical structure and it was very easy to use, but it
was a bit bloated. It contained lots of things that I
don't need.

Then I tried zprezto. It was less bloated but it was
a bit harder to use than oh-my-zsh.

After that I said to myself: "Shit man, use your own
configuration!" :) This contains exactly those things
that I need.

## Installation

Clone the repo. I suggest cloning it into your HOME directory:

```bash
$ cd
$ git clone git@github.com:jabbalaci/jabbas-zsh-settings.git
```

Create some symbolic links (these are required):

```bash
$ cd
$ ln -s jabbas-zsh-settings/.zsh
$ ln -s jabbas-zsh-settings/.zshenv
$ ln -s jabbas-zsh-settings/.zshrc
```

Start zsh to test if it works well. You should see a nice colored prompt:

```bash
$ zsh
```

If you have the balls, set zsh as your primary shell. Use the output of `which zsh`:

```bash
$ which zsh
/usr/bin/zsh
$ chsh -s /usr/bin/zsh
```

Finally, customize the first line of `~/.zshenv` if you cloned the repo
somewhere else. If you cloned it in your HOME directory, there is nothing
to do:

```bash
export ZSH_JABBAS_SETTINGS=$HOME/jabbas-zsh-settings
```


## Links

* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [zprezto](https://github.com/sorin-ionescu/prezto)
* [Jerome Dalbert's ZSH settings](https://github.com/jeromedalbert/dotfiles)
* [gotbletu's ZSH video series](https://www.youtube.com/playlist?list=PL66D9420766CE3902)
* etc.
