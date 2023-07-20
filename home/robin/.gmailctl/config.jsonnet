// Import the standard library
local lib = import 'gmailctl.libsonnet';

// Some useful variables on top
local me = 'robingertenbach@gmail.com';
local toMe = { to: me };


// The actual configuration
{
  // Mandatory header
  version: 'v1alpha3',
  author: {
    name: 'Robin Gertenbach',
    email: me,
  },

  rules: [
    // Banking
    {
      filter: {
        or: [
          { from: '*@lloydsbank.co.uk' },
          { from: '*@marcus.co.uk' },
          { from: '*@revolut.co.uk' },
          { from: '*@transferwise.co.uk' },
          { from: '*@wise.co.uk' },
          { from: '*morganstanley.com' },
          { from: '*halifax.co.uk' },
        ],
      },
      actions: { labels: ['Banking'] },
    },

    // JJ School
    {
      filter: {
        or: [
          { from: 'SC3072182a@schoolcomms.com' },
          { from: '*@scopay.co.uk' },
          { from: '*@fitforsport.co.uk' },
          { from: '*@junioradventuresgroup.co.uk' },
        ],
      },
      actions: { labels: ['JJ School'] },
    },

    // Government
    {
      filter: { or: [ { from: '*.gov.uk' } ] },
      actions: { labels: ['Government'] },
    },

    // Dentist
    {
      filter: { or: [ { from: 'pitshangerdental@gmail.com' } ] },
      actions: { labels: ['Dentist'] },
    },

    // Rent
    {
      filter: {
        or: [
          { from: 'oriontraffic@gmail.com' },
          { to: 'oriontraffic@gmail.com'},
        ],
      },
      actions: { labels: ['Flat/Agency'] },
    },

    // Relocation
    {
      filter: {
        or: [
          { from: '*@squareonerelo.com' },  // Shipping
          { from: '*@bennettinternational.com' },  // School
          { from: '*@relocity.com' },  // Destination Services
          { from: '*@cartus.com' },  // Overall Services
        ]
      },
      actions: { labels: ['Relo'] },
    },

    // Spam
    {
      filter: {
        or: [
          { from: '*@*.onmicrosoft.com' },
        ],
      },
      // gmail does not allow marking as spam.
      actions: { archive: true },
    }
  ],
}
