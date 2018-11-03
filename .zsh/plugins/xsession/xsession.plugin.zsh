# echo "# xsession plugin was called"    # debug

# .xsession-errors can grow huge... remove them
if [ ! -h $HOME/.xsession-errors ]
then
    /bin/rm $HOME/.xsession-errors 2>/dev/null
    ln -s /dev/null $HOME/.xsession-errors 2>/dev/null
fi

if [ ! -h $HOME/.xsession-errors.old ]
then
    /bin/rm $HOME/.xsession-errors.old 2>/dev/null
    ln -s /dev/null $HOME/.xsession-errors.old 2>/dev/null
fi
