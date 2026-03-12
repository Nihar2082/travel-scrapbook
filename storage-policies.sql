drop policy if exists "Public view trip photos" on storage.objects;
drop policy if exists "Public upload trip photos" on storage.objects;

create policy "Public view trip photos"
on storage.objects
for select
to public
using (bucket_id = 'trip-photos');

create policy "Public upload trip photos"
on storage.objects
for insert
to public
with check (bucket_id = 'trip-photos');
