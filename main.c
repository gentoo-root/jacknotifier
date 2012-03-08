/*
 * This file is part of jacknotifier - Jack Notification Daemon
 * Copyright (C) 2012 Maxim A. Mikityanskiy - <maxtram95@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <stdlib.h>

#include "dbus.h"
#include "notify.h"
#include "gettext.h"

int main(int argc, char *argv[])
{
	gettext_init();

	if (argc != 1) {
		printf("Usage: %s\n", argv[0]);
		exit(254);
	}
	if (!jn_notify_init()) {
		fprintf(stderr, "Unable to initialize libnotify\n");
		exit(1);
	}
	if (!jn_dbus_init()) {
		fprintf(stderr, "Unable to initialize D-Bus\n");
		exit(1);
	}
	jn_dbus_listen_events();
	jn_dbus_fini();
	jn_notify_fini();

	return 0;
}
