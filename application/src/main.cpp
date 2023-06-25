/*
  ___   _   _   ___   _   _ _____ ___   _   __
 / _ \ | \ | | / _ \ | \ | |_   _/ _ \ | | / /
/ /_\ \|  \| |/ /_\ \|  \| | | |/ /_\ \| |/ /
|  _  || . ` ||  _  || . ` | | ||  _  ||    \
| | | || |\  || | | || |\  | | || | | || |\  \
\_| |_/\_| \_/\_| |_/\_| \_/ \_/\_| |_/\_| \_/

Project PROGENY_PROJECT_NAME main.cpp
Initial file automatically generated by PROGENY on PROGENY_CURRENT_DATE
*/

#include "main.h" // include main header
#include "PROGENY_PROJECT_NAME.h" // include the default library

// include common headers by default
#include "stdio.h"
#include "stdlib.h"
#include <errno.h> // Error integer and strerror() function
#include <unistd.h> // write(), read(), close()
#include <fcntl.h> // Contains file controls like O_RDWR
#include <string>
#include <limits.h>
#include <chrono>
#include "stdbool.h"
#include <iostream>
#include <thread>
#include <mutex>
#include "plog/Log.h"
#include "plog/Initializers/RollingFileInitializer.h"
#include "plog/Initializers/ConsoleInitializer.h"
#include "CLI/App.hpp"
#include "CLI/Validators.hpp"
#include "CLI/Formatter.hpp"
#include "CLI/Config.hpp"

using namespace std; // default namespace

struct LogLevelValidator : public CLI::Validator {
    LogLevelValidator() {
        name_ = "severity";
        func_ = [](const std::string &str) {

            if(!(str == "NONE" || str == "VERB" || str == "DEBUG" || str == "INFO" || str == "WARN" || str == "ERROR" || str == "FATAL"))
                return std::string("Specified logging severity level is not an accepted string. You gave: " + str);
            else
                return std::string();
        };
    }
};
const static LogLevelValidator WarningLevel;

int main(int argc, char *argv[]){

    ////Set CLI defaults
    std::string logfilePath = "logs/PROGENY_PROJECT_NAME.log"; // Default logfile path
    std::string logSeverityInputStr = "WARN"; // default severity level of application-level logging

    ///// Configure and parse CLI options
    CLI::App cli{"-PROGENY_PROJECT_NAME application description-"};
    cli.add_option("-l,--logfile", logfilePath, "Logfile destination. Default: ./logs/PROGENY_PROJECT_NAME.log");
    cli.add_option("-s,--severity", logSeverityInputStr, "Logging minimum severity threshold. Default: INFO. Acceptable values:\n\tNONE (Dont log)\n\tVERB\n\tDEBUG\n\tINFO\n\tWARN\n\tERROR\n\tFATAL")->check(WarningLevel);

    CLI11_PARSE(cli);

    static plog::RollingFileAppender<plog::CsvFormatter> fileAppender(logfilePath.c_str(), 1048576, 3); // Create the file appender, up to 1MB per file, rolling over 3 files
    static plog::ConsoleAppender<plog::TxtFormatter> consoleAppender; // Create the console appender
    plog::Severity applicationLogSeverity = plog::severityFromString(logSeverityInputStr.c_str()); // stringify the log severity level from console input

    plog::init(applicationLogSeverity, &fileAppender).addAppender(&consoleAppender); // Initialize the logger with the both appenders.

    PLOGI << "Started logging.";
    PLOGD.printf("Printf style debug msg");

    PROGENY_PROJECT_NAME object;
    PROGENY_PROJECT_NAME object2;
    object.init(plog::warning, plog::get()); // Initialize a library with a PLOG appender, but only log warning (or higher) level messages.
    object2.init(plog::verbose, plog::get()); // Initialize a library with a PLOG appender, and log verbose messages.


    object.multiply(1, 2);
    object2.multiply(1, 2);

    cout << "Hello world" << endl;

    return EXIT_SUCCESS;
}





