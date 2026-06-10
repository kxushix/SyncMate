import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../domain/models/quote_card_model.dart';
import '../domain/models/quote_position.dart';

/// Mock data source for Quote Cards matching the 5 slides in hindi.html.
class MockQuotesData {
  static List<QuoteCardModel> getQuotes() {
    return [
      const QuoteCardModel(
        id: '1',
        quote:
            'कुछ रिश्तों में दिल को आज़ादी नइँ होती\nकुछ कमरों में रौशनदान नहीं होता है',
        author: 'Vikram Gaur Vairagi',
        backgroundImage: AppAssets.quoteBg1,
        position: QuotePosition.topCenter,
        textAlign: TextAlign.center,
        topPercent: 0.15,
        leftPercent: 0.5,
        // textColor: '#571414',
        textColor: '#FFFFFF',

        likeCount: 45,
      ),
      const QuoteCardModel(
        id: '2',
        quote:
            'जहाँ रहेगा वहीं रौशनी लुटाएगा\nकिसी चराग़ का अपना मकां नहीं होता',
        author: 'Allama Iqbal',
        backgroundImage: AppAssets.quoteBg2,
        position: QuotePosition.middleCenter,

        textAlign: TextAlign.center,
        topPercent: 0.5,
        leftPercent: 0.5,
        textColor: '#571414',
        likeCount: 22,
      ),
      const QuoteCardModel(
        id: '3',
        quote:
            'बाग़ में जाने के आदाब हुआ करते हैं\nकिसी तितली को न फूलों से उड़ाया जाए',
        author: 'Nida Fazli',
        backgroundImage: AppAssets.quoteBg3,
        position: QuotePosition.topCenter,
        textAlign: TextAlign.center,
        topPercent: 0.16,
        leftPercent: 0.5,
        textColor: '#FFFFFF',
        likeCount: 41,
        isSaved: true,
      ),
      const QuoteCardModel(
        id: '4',
        quote:
            'जलते हैं इक चराग़ की लौ से कई चराग़\nदुनिया तिरे ख़याल से रौशन हुई तो है',
        author: 'Shahzad Ahmad',
        backgroundImage: AppAssets.quoteBg1,
        position: QuotePosition.topCenter,
        textAlign: TextAlign.center,
        topPercent: 0.13,
        leftPercent: 0.5,
        textColor: '#FFFFFF',
        likeCount: 24,
      ),
      const QuoteCardModel(
        id: '5',
        quote:
            'उम्र भर कौन निभाता है तअल्लुक़ इतना\nऐ मेरी जान के दुश्मन तुझे अल्लाह रक्खे',
        author: 'Ahmad Faraz',
        backgroundImage: AppAssets.quoteBg2,
        position: QuotePosition.topLeft,
        textAlign: TextAlign.left,
        topPercent: 0.5,
        leftPercent: 0.08,
        textColor: '#571414',
        likeCount: 30,
      ),
    ];
  }
}
