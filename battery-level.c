#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define BATTERY_PATH "/sys/class/power_supply/BAT0/capacity"
#define CHARGING_PATH "/sys/class/power_supply/BAT0/status"

// void play_audio(char *path) {
//  char command[256];
//  sprintf(command, "paplay %s", path);
//  system(command);
// }

void play_audio(char *path) {
  // Replace this with your desired audio player command, also make sure you have the right audio in the right folders.
  char command[256];
  sprintf(command, "mpg123 -o pulse %s", path);
  system(command);
}

int main(int argc, char *argv[]) {
  int battery = 0;
  char charging_status[16];

  while (1) {
    // Read the battery level
    FILE *battery_file = fopen(BATTERY_PATH, "r");
    fscanf(battery_file, "%d", &battery);
    fclose(battery_file);

    // Read the charging status
    FILE *charging_file = fopen(CHARGING_PATH, "r");
    fscanf(charging_file, "%s", charging_status);
    fclose(charging_file);

    if (battery < 5 && strcmp(charging_status, "Discharging") == 0) {
      // Suspend the system
      // Make sure the audio is in the folder and with the same filename as below.
      play_audio("/usr/share/sounds/battery/5_percent.mp3");
      system("systemctl suspend");
    } else if (battery < 10 && strcmp(charging_status, "Discharging") == 0) {
      // Play audio 1
      play_audio("/usr/share/sounds/battery/10_percent.mp3");
    } else if (battery < 20 && strcmp(charging_status, "Discharging") == 0) {
      // Play audio 2
      play_audio("/usr/share/sounds/battery/20_percent.mp3");
    }

    // Sleep for 1 minute before checking again
    sleep(60);
  }

  return 0;
}
