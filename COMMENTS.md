# NOCLIST README

## Development environment

| <!-- -->    | <!-- -->    |
|-----|--------|
| OS | Ubuntu 22.04 LTS |
| Ruby | 3.0.5 |

## Setup and run
1. Clone the project to your local machine.
    
    ```git clone https://github.com/lundersaur/CFPB_Noclist```

2. Ensure that Ruby 3.0.5 is installed. If not is available, [rbenv](https://github.com/rbenv/rbenv) offers the ability to run multiple versions in parallel and is well-documented.

3. Configure the endpoint the script should use by opening `bad_sec_client.rb` and updating the `BADSEC_URI` constant. Based on the [Ad Hoc example](https://homework.adhoc.team/noclist/#running-the-server), it is set to http://0.0.0.0:8888 by default.

4. In the terminal, run `ruby bad_sec_client.rb` -- it should return an array of strings if not error was encountered. You can check the response code with `echo $?` after the script finishes, with `0` indicating no error was encountered and `1` indicating there was an issue.

