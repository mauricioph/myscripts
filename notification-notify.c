/*
    sudo apt install libnotify-dev
    Dependency: libnotify
    Build with: gcc -o notification-notify `pkg-config --cflags --libs libnotify` notification-notify.c
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libnotify/notify.h>
#define BUFFER_SIZE 1000

int main()
{
    /* File pointer to hold reference to our file */
    FILE * fPtr;
    char buffer[BUFFER_SIZE];
    int totalRead = 0;

    /* 
     * Open file in r (read) mode. 
     * "data/file2.txt" is complete file path to read
     */
    fPtr = fopen("/sys/class/power_supply/BAT1/status", "r");

    /* fopen() return NULL if last operation was unsuccessful */
    if(fPtr == NULL)
    {
        /* Unable to open file hence exit */
        printf("Unable to open file.\n");
        printf("Please check whether file exists and you have read privilege.\n");
        exit(EXIT_FAILURE);
    }

    /* Repeat this until read line is not NULL */
    while(fgets(buffer, BUFFER_SIZE, fPtr) != NULL) 
    {
        /* Total character read count */
        totalRead = strlen(buffer);

        /* Trim new line character from last if exists. */
        buffer[totalRead - 1] = buffer[totalRead - 1] == '\n' 
                                    ? '\0' 
                                    : buffer[totalRead - 1];
        /* Print line read on cosole */
        printf("%s\n", buffer);
    }
/* This is the second file */

    FILE * fCpc;
    char cpbuffer[BUFFER_SIZE];
    int cptotalRead = 0;
    fCpc = fopen("/sys/class/power_supply/BAT1/capacity", "r");
    if(fCpc == NULL)
    {
        printf("Unable to open file.\n");
        printf("Please check whether file exists and you have read privilege.\n");
        exit(EXIT_FAILURE);
    }


    while(fgets(cpbuffer, BUFFER_SIZE, fCpc) != NULL) 
    {
        cptotalRead = strlen(cpbuffer);
        cpbuffer[cptotalRead - 1] = cpbuffer[cptotalRead - 1] == '\n' 
                                    ? '\0' 
                                    : cpbuffer[cptotalRead - 1];
        printf("%s\n", cpbuffer);

/* This is the end of second file */

    } 
 notify_init ("Battery Level");
 NotifyNotification * Notificacao = notify_notification_new (("Battery %d", buffer), ("The battery is %s", cpbuffer), "battery");
 notify_notification_show (Notificacao, NULL);
 g_object_unref(G_OBJECT(Notificacao));
 notify_uninit();
 return 0;

    /* Done with this file, close file to release resource */
    fclose(fPtr);
    fclose(fCpc);

    return 0;
}


