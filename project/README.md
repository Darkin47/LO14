# Vsh Script

Vsh is a bash script that allow you to create an archive server and also to connect to a server in order to browse or extract an archive.
The archives are text file with header and then content of files. Unfortunately, there is currently no function to create an archive based on a directory but there is an archive example provided in the `archives` directory.

## How to use

### Start/Stop server

* To start a server :
<pre>
	./vsh -start [destination]* [port] [archive_directory]*
</pre>
* To stop a server :
<pre>
	./vsh -stop [destination]* [port]
</pre>

> *: optional.

### Client connection

* To display the archives available on a server :
<pre>
	./vsh -list [destination] [port]
</pre>
* To browse an archive :
<pre>
	./vsh -browse [destination] [port] [archive_name]
</pre>
* To extract an archive on your computer :
<pre>
	./vsh -extract [destination] [port] [archive_name]
</pre>

### Using browse mode

While using browse mode, there is a lot of linux-like command such as cd, ls, pwd, rm, etc.
Type help to show them all.

## Credits

* [Julien Grave](https://github.com/darkin47)
* [Lucas Soulier](https://github.com/lonk)
* [All Contributors](https://github.com/lonk/lo14/graphs/contributors)

## License

The MIT License (MIT). Please see [License File](https://github.com/Darkin47/LO14/blob/master/project/LICENSE) for more information.
