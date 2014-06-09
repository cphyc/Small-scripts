#!/bin/sh
acpi -b | cut -d ',' -f 2 | cut -d '%' -f 1 | cut -d " " -f 2
