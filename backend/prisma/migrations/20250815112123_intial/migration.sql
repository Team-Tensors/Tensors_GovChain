-- CreateTable
CREATE TABLE "public"."government_department" (
    "department_id" SERIAL NOT NULL,
    "department_code" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "government_department_pkey" PRIMARY KEY ("department_id")
);

-- CreateTable
CREATE TABLE "public"."government_officer" (
    "officer_id" SERIAL NOT NULL,
    "department_id" INTEGER NOT NULL,
    "employee_id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "email" TEXT,
    "position" TEXT,
    "is_active" BOOLEAN,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "government_officer_pkey" PRIMARY KEY ("officer_id")
);

-- CreateTable
CREATE TABLE "public"."location" (
    "location_id" SERIAL NOT NULL,
    "department_id" INTEGER NOT NULL,
    "location_name" TEXT,
    "city" TEXT,
    "postal_code" TEXT,
    "decimal_longitude" DECIMAL(65,30),
    "decimal_latitude" DECIMAL(65,30),
    "directions" TEXT,
    "is_active" BOOLEAN,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "location_pkey" PRIMARY KEY ("location_id")
);

-- CreateTable
CREATE TABLE "public"."service" (
    "service_id" SERIAL NOT NULL,
    "department_id" INTEGER NOT NULL,
    "service_name" TEXT,
    "description" TEXT,
    "fee_amount" DECIMAL(65,30),
    "is_active" BOOLEAN,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "service_pkey" PRIMARY KEY ("service_id")
);

-- CreateTable
CREATE TABLE "public"."user" (
    "user_id" SERIAL NOT NULL,
    "first_name" TEXT,
    "last_name" TEXT,
    "email" TEXT,
    "phone_number" TEXT,
    "password_hash" TEXT,
    "is_active" BOOLEAN,
    "user_type" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "public"."time_slot" (
    "slot_id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3),
    "start_time" TIMESTAMP(3),
    "end_time" TIMESTAMP(3),
    "max_capacity" INTEGER,
    "is_available" BOOLEAN,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "time_slot_pkey" PRIMARY KEY ("slot_id")
);

-- CreateTable
CREATE TABLE "public"."analytics_log" (
    "log_id" SERIAL NOT NULL,
    "department_id" INTEGER NOT NULL,
    "metric_type" TEXT,
    "metric_value" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "analytics_log_pkey" PRIMARY KEY ("log_id")
);

-- CreateTable
CREATE TABLE "public"."appointment" (
    "appointment_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "service_id" INTEGER NOT NULL,
    "location_id" INTEGER NOT NULL,
    "appointment_date" TIMESTAMP(3),
    "time" TIMESTAMP(3),
    "requirements" TEXT,
    "confirmation_number" TEXT,
    "booking_history" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "appointment_pkey" PRIMARY KEY ("appointment_id")
);

-- CreateTable
CREATE TABLE "public"."document_requirement" (
    "requirement_id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "document_type" TEXT,
    "document_name" TEXT,
    "is_mandatory" BOOLEAN,
    "description" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_requirement_pkey" PRIMARY KEY ("requirement_id")
);

-- CreateTable
CREATE TABLE "public"."notification" (
    "notification_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "notification_type" TEXT,
    "subject" TEXT,
    "delivery_method" TEXT,
    "status" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notification_pkey" PRIMARY KEY ("notification_id")
);

-- CreateTable
CREATE TABLE "public"."user_document" (
    "user_document_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "requirement_id" INTEGER NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "original_filename" TEXT,
    "filename" TEXT,
    "file_path" TEXT,
    "upload_status" TEXT,
    "uploaded_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_document_pkey" PRIMARY KEY ("user_document_id")
);

-- CreateTable
CREATE TABLE "public"."appointment_history" (
    "history_id" SERIAL NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "history" TEXT,
    "previous_status" TEXT,
    "new_status" TEXT,
    "changed_by" INTEGER,
    "remarks" TEXT,
    "changed_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "appointment_history_pkey" PRIMARY KEY ("history_id")
);

-- CreateTable
CREATE TABLE "public"."feedback" (
    "feedback_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "feedback" TEXT,
    "comments" TEXT,
    "suggestions" TEXT,
    "is_anonymous" BOOLEAN,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "feedback_pkey" PRIMARY KEY ("feedback_id")
);

-- CreateTable
CREATE TABLE "public"."_AppointmentToDocumentRequirement" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_AppointmentToDocumentRequirement_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "public"."_AppointmentToTimeSlot" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_AppointmentToTimeSlot_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "government_officer_employee_id_key" ON "public"."government_officer"("employee_id");

-- CreateIndex
CREATE UNIQUE INDEX "government_officer_email_key" ON "public"."government_officer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "public"."user"("email");

-- CreateIndex
CREATE INDEX "_AppointmentToDocumentRequirement_B_index" ON "public"."_AppointmentToDocumentRequirement"("B");

-- CreateIndex
CREATE INDEX "_AppointmentToTimeSlot_B_index" ON "public"."_AppointmentToTimeSlot"("B");

-- AddForeignKey
ALTER TABLE "public"."government_officer" ADD CONSTRAINT "government_officer_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."government_department"("department_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."location" ADD CONSTRAINT "location_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."government_department"("department_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."service" ADD CONSTRAINT "service_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."government_department"("department_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."time_slot" ADD CONSTRAINT "time_slot_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."service"("service_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."analytics_log" ADD CONSTRAINT "analytics_log_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."government_department"("department_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointment" ADD CONSTRAINT "appointment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointment" ADD CONSTRAINT "appointment_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."service"("service_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointment" ADD CONSTRAINT "appointment_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."location"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."document_requirement" ADD CONSTRAINT "document_requirement_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."service"("service_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."notification" ADD CONSTRAINT "notification_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "public"."appointment"("appointment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_document" ADD CONSTRAINT "user_document_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_document" ADD CONSTRAINT "user_document_requirement_id_fkey" FOREIGN KEY ("requirement_id") REFERENCES "public"."document_requirement"("requirement_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_document" ADD CONSTRAINT "user_document_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "public"."appointment"("appointment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointment_history" ADD CONSTRAINT "appointment_history_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "public"."appointment"("appointment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointment_history" ADD CONSTRAINT "appointment_history_changed_by_fkey" FOREIGN KEY ("changed_by") REFERENCES "public"."government_officer"("officer_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."feedback" ADD CONSTRAINT "feedback_appointment_id_fkey" FOREIGN KEY ("appointment_id") REFERENCES "public"."appointment"("appointment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_AppointmentToDocumentRequirement" ADD CONSTRAINT "_AppointmentToDocumentRequirement_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."appointment"("appointment_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_AppointmentToDocumentRequirement" ADD CONSTRAINT "_AppointmentToDocumentRequirement_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."document_requirement"("requirement_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_AppointmentToTimeSlot" ADD CONSTRAINT "_AppointmentToTimeSlot_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."appointment"("appointment_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_AppointmentToTimeSlot" ADD CONSTRAINT "_AppointmentToTimeSlot_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."time_slot"("slot_id") ON DELETE CASCADE ON UPDATE CASCADE;
