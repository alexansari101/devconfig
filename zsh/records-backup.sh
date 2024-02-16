#!/bin/bash

backup_records() {
	cd $HOME

	local recs_fldr="personal_records"

	echo "Compressing ${recs_fldr}..."
	tar czvhf "${recs_fldr}.tar.gz" "${recs_fldr}"

	echo "Encrypting ${recs_fldr}..."
	gpg -c "${HOME}/${recs_fldr}.tar.gz"
	rm "${recs_fldr}.tar.gz"

	if [ -z "$BACKUP_PATH" ]; then  # check if BACKUP_PATH is empty
		echo "ENV variable BACKUP_PATH not defined, skipping move operation..."
	else
		echo "Backing up ${recs_fldr} to ${BACKUP_PATH}..."
		mv "${recs_fldr}.tar.gz.gpg" "${BACKUP_PATH}"  # move operation when BACKUP_PATH is defined
	fi

	cd -

	echo "done."
}
