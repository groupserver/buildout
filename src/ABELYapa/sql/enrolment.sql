CREATE TABLE offering (
  offering_id   TEXT                      PRIMARY KEY,
  name          TEXT                      NOT NULL,
  course_id     TEXT                      NOT NULL,
  open_date     TIMESTAMP WITH TIME ZONE  NOT NULL,
  close_date    TIMESTAMP WITH TIME ZONE  NOT NULL
);

CREATE TABLE enrolment (
  user_id             TEXT                      NOT NULL,
  offering_id         TEXT                      NOT NULL REFERENCES offering(offering_id),
  enrolled_date       TIMESTAMP WITH TIME ZONE  NOT NULL,
  adding_user_id      TEXT                      NOT NULL,
  left_date           TIMESTAMP WITH TIME ZONE,
  reason_left         TEXT,
  removing_user_id    TEXT
);
CREATE UNIQUE INDEX USER_ENROLMENT_PKEY 
ON enrolment
USING BTREE(user_id, offering_id);

