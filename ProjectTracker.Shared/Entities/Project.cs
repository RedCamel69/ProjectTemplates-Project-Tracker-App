﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectTracker.Shared.Entities
{
    public class Project : SoftDeleteableEntity
    {
        public required string Name { get; set; }
        public List<TimeEntry> TimeEntries { get; set; } = new List<TimeEntry>();
        public ProjectDetails? ProjectDetails { get; set; }
        public List<User> Users { get; set; } = new List<User>();
    }
}