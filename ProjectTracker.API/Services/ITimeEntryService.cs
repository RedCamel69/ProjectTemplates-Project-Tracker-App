﻿using ProjectTracker.Shared.Models.TimeEntry;

namespace ProjectTracker.API.Services
{
    public interface ITimeEntryService
    {
        TimeEntryResponse? GetTimeEntryById(int id);
        List<TimeEntryResponse> GetAllTimeEntries();
        List<TimeEntryResponse> CreateTimeEntry(TimeEntryCreateRequest timeEntry);
        List<TimeEntryResponse>? UpdateTimeEntry(int id, TimeEntryUpdateRequest timeEntry);
        List<TimeEntryResponse>? DeleteTimeEntry(int id);
    }
}
